;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_atoi_base_bonus.s                               :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/16 02:26:05 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/23 18:27:28 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	; int args_are_valid(char *str, char *base);
	extern	_ft_strchr
	extern	_ft_strisnonrepeat
_args_are_valid:
	push	rbp			; function prologue
	mov	rbp, rsp
	sub	rsp, 16			; 8 extra bytes for alignment
	mov	[rbp - 8], rsi		; save volatile register
	test	rdi, rdi
	jz	.error			; if (str == NULL)

	test	rsi, rsi
	jz	.error			; if (base == NULL)

	cmp	byte [rdi], 0
	je	.error			; if (!*str)

	cmp	byte [rsi], 0
	je	.error			; if (!*base)

	cmp	byte [rsi + 1], 0
	je	.error			; if (!*(base + 1))

	mov	rdi, rsi		; char *base -> rdi
	mov	rsi, '+'
	call	_ft_strchr
	test	rax, rax
	jnz	.error			; base contains '+'

	mov	rdi, [rbp - 8]		; char *base -> rdi
	mov	rsi, '-'
	call	_ft_strchr
	test	rax, rax
	jnz	.error			; base contains '-'

	mov	rdi, [rbp - 8]		; char *base -> rdi
	call	_ft_strisnonrepeat	; check if base contains repeating characters
	jmp	.done
.error:
	xor	rax, rax
.done:
	mov	rsp, rbp		; function epilogue
	pop	rbp
	ret


	section	.text
	; int ft_atoi_base(char *str, char *base);
	global	_ft_atoi_base
	extern	_ft_strlen
	extern	_ft_strchr
_ft_atoi_base:
	push	rbp			; function prologue
	mov	rbp, rsp
	sub	rsp, 48			; 8 extra bytes for alignment
	mov	[rbp - 8], rbx		; save nonvolatile register
	mov	[rbp - 16], r12		; save nonvolatile register
	mov	[rbp - 24], r13		; save nonvolatile register
	mov	[rbp - 32], r14		; save nonvolatile register
	mov	[rbp - 40], r15		; save nonvolatile register
	mov	rbx, rdi		; char *str -> rbx
	mov	r12, rsi		; char *base -> r12

	call	_args_are_valid		; should return 1 if true
	test	rax, rax
	jz	.error			; invalid argument(s)

	mov	rdi, r12		; we need the length of the base
	call	_ft_strlen
	mov	r13, rax		; radix -> r13
	xor	r14, r14		; number's sign -> r14
	xor	r15, r15		; the resulting number is stored in r15d (4 byte int)
	mov	r8b, [rbx]		; need to process optional '+' or '-'
	cmp	r8b, '-'
	jne	.test_opt_plus

	dec	r14			; set number sign
	inc	rbx			; skip optional '-' sign
	jmp	.loop
.test_opt_plus:
	inc	r14			; set number sign
	cmp	r8b, '+'
	jne	.loop

	inc	rbx			; skip optional '+' sign
.loop:
	mov	r8b, [rbx]		; load current string symbol in r8b
	test	r8b, r8b		; have we reached the end of the string?
	jz	.break			; conversion is complete

	; CORE PART OF THE CONVERSION:
	; nbr = nbr * radix + (ft_strchr(base, *str) - base);

	imul	r15, r13		; first, multiply number by radix
	jo	.error			; overflow of 8 byte integer

	mov	rdi, r12		; char *base -> rdi
	mov	sil, r8b		; str[i] -> rsi
	call	_ft_strchr
	test	rax, rax
	jz	.error			; str contains characters that aren't part of the base

	sub	rax, r12		; current digit is ft_strchr(base, *str) - base
	add	r15, rax		; add current digit to the resulting number
	jo	.error			; overflow of 8 byte integer

	inc	rbx			; increment string pointer
	jmp	.loop
.break:
	mov	r8, 2147483648		; cmp doesn't work with 64 bit immed
	cmp	r15, r8			; check for possible integer overflow
	ja	.error			; nbr won't fit in a 4 byte int

	jb	.no_overflow		; anything less will fit in either positive or negative form

	cmp	r14, -1
	jne	.error			; only a negative number can hold an abs value of 2147483648
.no_overflow:
	imul	r15, r14		; multiply nbr with sign
	jmp	.done			; and return it
.error:
	xor	r15, r15		; on error function returns 0
.done:
	mov	eax, r15d		; store the result in eax
	mov	rbx, [rbp - 8]		; restore nonvolatile register
	mov	r12, [rbp - 16]		; restore nonvolatile register
	mov	r13, [rbp - 24]		; restore nonvolatile register
	mov	r14, [rbp - 32]		; restore nonvolatile register
	mov	r15, [rbp - 40]		; restore nonvolatile register
	mov	rsp, rbp		; function epilogue
	pop	rbp
	ret
