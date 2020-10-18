;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_atoi_base_bonus.s                               :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/16 02:26:05 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/18 06:56:59 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	extern	_ft_strchr
	extern	_ft_strisunique
args_are_valid:
	sub	rsp, 24			; allocate space for locals + realign rsp
	mov	[rsp], rdi		; save nonvolatile register
	mov	[rsp + 8], rsi		; save nonvolatile register
	
	test	rdi, rdi		; check if str == NULL
	jz	.error

	test	rsi, rsi		; check if base == NULL
	jz	.error

	cmp	byte [rdi], 0		; check if str is an empty string
	je	.error

	cmp	byte [rsi], 0		; check if base is an empty string
	je	.error

	cmp	byte [rsi + 1], 0	; check if base is of size 1
	je	.error

	mov	rdi, rsi		; rdi now contains char *base
	mov	rsi, '+'		; second argument to ft_strchr
	call	_ft_strchr
	test	rax, rax		; check if base contains '+'
	jnz	.error

	mov	rsi, '-'		; second argument to ft_strchr
	call	_ft_strchr
	test	rax, rax		; check if base contains '-'
	jnz	.error

	call	_ft_strisunique
	test	rax, rax		; check if base contains repeating characters
	jz	.error
	jmp	.done
.error:
	xor	rax, rax
.done:
	mov	rdi, [rsp]		; restore rdi
	mov	rsi, [rsp + 8]		; restore rsi
	add	rsp, 24			; restore rsp
	ret


	section	.text
	global	_ft_atoi_base
	extern	_ft_strlen
	extern	_ft_strchr
_ft_atoi_base:

	; save all nonvolatile registers
	; that we're going to use

	push	rbp			; rbp is [rsp + 48] -> sign
	push	rdi			; rdi is [rsp + 40] -> str
	push	rsi			; rsi is [rsp + 32] -> base
	push	r12			; r12 is [rsp + 24] -> radix
	push	r13			; r13 is [rsp + 16] -> index
	push	r14			; r14 is [rsp +  8] -> nbr
	push	r15			; r15 is [rsp +  0] -> str[index]

	call	args_are_valid		; should return 1 if true
	test	rax, rax
	jz	.error			; invalid argument(s)

	mov	rdi, rsi		; we need the length of the base
	call	_ft_strlen
	mov	r12, rax		; r12 will hold the value of radix
	mov	rdi, [rsp + 40]		; restore rdi after the call
	xor	r13, r13		; string index
	xor	r14, r14		; the resulting number is stored in r14d (4 byte int)
	xor	rbp, rbp		; store number's sign in rbp
	mov	r8b, [rdi]		; need to process optional + or -
	cmp	r8b, '-'
	jne	.test_opt_plus

	dec	rbp
	inc	r13			; skip optional - sign
	jmp	.loop
.test_opt_plus:
	inc	rbp			; set number sign
	cmp	r8b, '+'
	jne	.loop

	inc	r13			; skip optional + sign
.loop:
	mov	r15b, [rdi + r13]	; load current string symbol in r15b
	test	r15b, r15b		; have we reached the end of the string?
	jz	.break			; conversion is complete

	; CORE PART OF THE CONVERSION:
	; nbr = nbr * radix + (ft_strchr(base, *str) - base);

	imul	r14, r12		; first, multiply number by radix
	jo	.error			; overflow of 8 byte integer

	mov	rdi, rsi		; first argument to ft_strchr
	mov	sil, r15b		; second argument to ft_strchr  
	call	_ft_strchr
	test	rax, rax
	jz	.error			; str contains characters that aren't part of the base

	mov	rdi, [rsp + 40]		; restore rdi
	mov	rsi, [rsp + 32]		; restore rsi
	sub	rax, rsi		; current digit is ft_strchr(base, *str) - base
	add	r14, rax		; add current digit to the resulting number
	jo	.error			; overflow of 8 byte integer

	inc	r13			; increment string index
	jmp	.loop
.break:
	mov	r13, 2147483648		; cmp doesn't work with 64 bit immed
	cmp	r14, r13		; check for possible integer overflow
	ja	.error			; nbr won't fit in a 4 byte int
	jb	.no_overflow		; anything less will fit in either positive or negative form
	cmp	rbp, -1
	jne	.error			; only a negative number can hold an abs value of 2147483648
.no_overflow:
	imul	r14, rbp		; multiply nbr with sign
	jmp	.done			; and return it
.error:
	xor	r14, r14		; on error function returns 0
.done:
	mov	eax, r14d		; store the result in eax

	; restore all nonvolatile registers

	pop	r15
	pop	r14
	pop	r13
	pop	r12
	pop	rsi
	pop	rdi
	pop	rbp
	ret
