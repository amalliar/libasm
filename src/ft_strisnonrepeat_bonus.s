;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_strisnonrepeat_bonus.s                          :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/16 06:49:54 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/22 15:43:58 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	; void ft_strisnonrepeat(char *str);
	global	_ft_strisnonrepeat
_ft_strisnonrepeat:
	push	r12			; save nonvolatile register
	xor	rdx, rdx		; set counter to 0
	xor	r8, r8			; flag table for symbols 0-63    [Q0]
	xor	r9, r9			; flag table for symbols 64-127  [Q1]
	xor	r10, r10		; flag table for symbols 128-191 [Q2]
	xor	r11, r11		; flag table for symbols 192-255 [Q3]
	xor	rax, rax
	inc	rax			; return true by default
.loop:
	mov	cl, [rdi + rdx]		; load current symbol into a cl register
	test	cl, cl
	jz	.done			; if we've just reached the null-terminator

	xor	r12, r12		; bit mask to test if the current symol
	inc	r12			; is already in the table
	rol	r12, cl
	cmp	cl, 64
	jb	.test_q0

	cmp	cl, 128
	jb	.test_q1

	cmp	cl, 192
	jb	.test_q2

	jmp	.test_q3
.test_q0:
	test	r8, r12
	jnz	.return_false		; string contains repeating symbols

	or	r8, r12			; set the bit of the current symbol
	inc	rdx
	jmp	.loop
.test_q1:
	test	r9, r12
	jnz	.return_false		; string contains repeating symbols

	or	r9, r12			; set the bit of the current symbol
	inc	rdx
	jmp	.loop
.test_q2:
	test	r10, r12
	jnz	.return_false		; string contains repeating symbols

	or	r10, r12		; set the bit of the current symbol
	inc	rdx
	jmp	.loop
.test_q3:
	test	r11, r12
	jnz	.return_false		; string contains repeating symbols

	or	r11, r12		; set the bit of the current symbol
	inc	rdx
	jmp	.loop
.return_false:
	xor	rax, rax
.done:
	pop	r12			; restore nonvolatile register
	ret
