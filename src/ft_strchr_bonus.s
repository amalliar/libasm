;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_strchr_bonus.s                                  :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/13 05:43:23 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/16 05:18:13 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	global	_ft_strchr
_ft_strchr:
	xor	rcx, rcx		; set rcx to 0
.loop:
	cmp	byte [rdi + rcx], sil	; check if str[i] == c
	je	.found
	cmp	byte [rdi + rcx], 0	; check whether the null-terminator is reached
	je	.not_found
	inc	rcx			; increment string index
	jmp	.loop			; test next byte
.found:
	lea	rax, [rdi + rcx]
	ret
.not_found:
	xor	rax, rax
	ret
