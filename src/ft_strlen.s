;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_strlen.s                                        :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/13 05:43:23 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/16 09:08:37 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	global	_ft_strlen
_ft_strlen:
	xor	rax, rax		; set rax to 0
.loop:
	cmp	byte [rdi + rax], 0	; check whether the null-terminator is reached
	je	.done			; null-terminator found
	inc	rax			; increment total string length
	jmp	.loop			; test next byte
.done:
	ret
