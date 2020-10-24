;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_strchr_bonus.s                                  :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/13 05:43:23 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/23 18:05:27 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	; char	*ft_strchr(const char *s, int c);
	global	_ft_strchr
_ft_strchr:
	xor	rax, rax		; by default rax is NULL
.loop:
	cmp	byte [rdi], sil		; check if *str == c
	je	.found

	cmp	byte [rdi], 0		; check whether the null-terminator is reached
	je	.not_found

	inc	rdi			; increment string address
	jmp	.loop			; test next byte
.found:
	mov	rax, rdi		; load current address into rax
.not_found:
	ret
