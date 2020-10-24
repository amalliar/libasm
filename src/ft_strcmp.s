;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_strcmp.s                                        :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/13 23:21:02 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/23 16:32:54 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	; int	ft_strcmp(const char *s1, const char *s2);
	global	_ft_strcmp
_ft_strcmp:
	xor	rcx, rcx		; rcx is array index
	dec	rcx			; decrement by one to compensate for loop inc
.loop:
	inc	rcx
	mov	al, [rdi + rcx]		; move 1 byte to al register
	cmp	al, [rsi + rcx]		; compare to one byte from the other string
	jne	.done			; if not equal return the difference

	test	al, al			; check whether one of the strings has ended
	jnz	.loop
.done:
	movzx	eax, al			; zero-extend al to eax
	movzx	edx, byte [rsi + rcx]	; zero-extend last checked byte from second string
	sub	eax, edx		; calculate the difference
	ret
