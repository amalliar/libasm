;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_strcpy.s                                        :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/13 21:19:41 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/23 19:36:40 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	; char	*ft_strcpy(char *dst, const char *src);
	global	_ft_strcpy
_ft_strcpy:
	push	rdi			; save dest
.loop:
	lodsb				; load 1 byte from src to al register
	stosb				; copy 1 byte from al to dest
	test	al, al			; check whether the null-terminator is reached
	jnz	.loop			; loop if al != 0

	pop	rax			; function returns dest
	ret
