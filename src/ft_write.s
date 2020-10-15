;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_write.s                                         :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/15 02:51:48 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/15 09:39:37 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	global	_ft_write
	extern	___error
_ft_write:
	mov	rax, 0x2000004		; write syscall
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
