;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_strcmp.s                                        :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/13 23:21:02 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/16 00:25:37 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	global	_ft_strcmp
_ft_strcmp:
	xor	rcx, rcx		; rcx is array index
	dec	rcx			; decrement by one to compensate for loop inc
.loop:
	inc	rcx
	mov	al, [rdi + rcx]		; move 1 byte to al register
	cmp	al, [rsi + rcx]		; compare to one byte from the other string
	jne	.break			; if not equal return the difference
	test	al, al			; check whether one of the strings has ended
	jnz	.loop
.break:
	movzx	eax, al			; zero-extend al to eax
	movzx	edx, byte [rsi + rcx]	; zero-extend last checked byte from second string
	sub	eax, edx		; calculate the difference
	ret
