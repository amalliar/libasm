;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_strisnonrepeat_bonus.s                          :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/16 06:49:54 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/23 18:20:11 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	; void ft_strisnonrepeat(char *str);
	global	_ft_strisnonrepeat
_ft_strisnonrepeat:
	xor	r8, r8			; flag table for symbols 0-63    [q0]
	xor	r9, r9			; flag table for symbols 64-127  [q1]
	xor	r10, r10		; flag table for symbols 128-191 [q2]
	xor	r11, r11		; flag table for symbols 192-255 [q3]
	xor	rax, rax
	inc	rax			; return true by default
.loop:
	mov	cl, [rdi]		; load current symbol into cl register
	inc	rdi			; ++str;
	test	cl, cl
	jz	.done			; if we've just reached the null-terminator

	xor	rdx, rdx		; bit mask to test if the current symol
	inc	rdx			; is already in the table
	rol	rdx, cl
	cmp	cl, 64
	jb	.test_q0

	cmp	cl, 128
	jb	.test_q1

	cmp	cl, 192
	jb	.test_q2

	jmp	.test_q3
.test_q0:
	test	r8, rdx
	jnz	.return_false		; string contains repeating symbols

	or	r8, rdx			; set the bit of the current symbol
	jmp	.loop
.test_q1:
	test	r9, rdx
	jnz	.return_false		; string contains repeating symbols

	or	r9, rdx			; set the bit of the current symbol
	jmp	.loop
.test_q2:
	test	r10, rdx
	jnz	.return_false		; string contains repeating symbols

	or	r10, rdx		; set the bit of the current symbol
	jmp	.loop
.test_q3:
	test	r11, rdx
	jnz	.return_false		; string contains repeating symbols

	or	r11, rdx		; set the bit of the current symbol
	jmp	.loop
.return_false:
	xor	rax, rax
.done:
	ret
