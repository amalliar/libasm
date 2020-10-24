;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_strlen.s                                        :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/13 05:43:23 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/23 16:10:57 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	; size_t ft_strlen(const char *s);
	global	_ft_strlen
_ft_strlen:
	xor	rax, rax
	dec	rax			; set rax to -1
.loop:
	inc	rax			; increment total string length
	cmp	byte [rdi + rax], 0	; check whether the null-terminator is reached
	jne	.loop			; test next byte

	ret
