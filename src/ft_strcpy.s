;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_strcpy.s                                        :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/13 21:19:41 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/14 04:00:41 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	global	_ft_strcpy
_ft_strcpy:
	push	rdi			; save nonvolatile register
	push	rsi			; save nonvolatile register
.loop:
	lodsb				; load 1 byte from src to al register
	stosb				; copy 1 byte from al to dest
	test	al, al			; check whether the null-terminator is reached
	jnz	.loop			; loop if al != 0

	pop	rsi			; restore nonvolatile register
	pop	rdi			; restore nonvolatile register
	mov	rax, rdi		; function returns dest
	ret
