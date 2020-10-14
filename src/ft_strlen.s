;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_strlen.s                                        :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/13 05:43:23 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/14 04:47:48 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	global	_ft_strlen
_ft_strlen:
	xor	rax, rax		; set rax to 0
.loop:
	cmp	byte [rdi + rax], 0x00	; check whether the null-terminator is reached
	je	.break			; null-terminator found
	inc	rax			; increment total string length
	jmp	.loop			; test next byte
.break:
	ret
