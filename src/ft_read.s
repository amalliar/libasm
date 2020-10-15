;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_read.s                                          :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/15 05:37:15 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/15 09:37:04 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	global	_ft_read
	extern	___error
_ft_read:
	mov	rax, 0x2000003		; read syscall
	syscall
	jnc	.done			; syscall errors set CF flag

	push	rax			; save errno value + align rsp
	call	___error		; get errno variable location
	pop	rdx			; restore errno value
	mov	dword [rax], edx	; set errno value
	xor	rax, rax		; set rax to -1 to indicate an error
	dec	rax
.done:
	ret
