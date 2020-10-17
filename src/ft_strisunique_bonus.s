;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_strisunique_bonus.s                             :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/16 06:49:54 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/16 08:37:55 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
is_unique:
	xor	rax, rax		; by default rax is set to 0, i.e. false
	xor	r10, r10		
	inc	r10
	rol	r10, cl			; use r10 to test current bit, i.e. 8 is r10 << 8
	cmp	cl, 128			; flags for the upper half are stored in r9
	ja	.test_upper

	test	r8, r10
	jnz	.return_false		; this bit has already been set

	or	r8, r10			; set current bit to 1
	inc	rax			; the symbol is unique
	jmp	_ft_strisunique.continue
.test_upper:
	test	r9, r10
	jnz	.return_false		; this bit has already been set

	or	r9, r10			; set current bit to 1
	inc	rax			; the symbol is unique
.return_false:
	jmp	_ft_strisunique.continue
	

	section	.text
	global	_ft_strisunique
_ft_strisunique:
	xor	rdx, rdx		; set counter to 0
	xor	r8, r8			; flag table for symbols 0-127
	xor	r9, r9			; flag table for symbols 128-255
.loop:
	mov	cl, [rdi + rdx]		; load current symbol into a cl register
	test	cl, cl			; test if we've reached the null-terminator
	jz	.return_true

	jmp	is_unique		; check if current symbol is unique
.continue:
	test	rax, rax
	jz	.return_false		; string contains repeating symbols

	inc	rdx
	jmp	.loop			; test next symbol
.return_true:
	xor	rax, rax
	inc	rax
	ret
.return_false:
	xor	rax, rax
	ret
