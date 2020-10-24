;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_write.s                                         :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/15 02:51:48 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/23 19:16:09 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	;ssize_t ft_write(int fildes, const void *buf, size_t nbyte);
	global	_ft_write
	extern	___error
_ft_write:
	push	rbp			; realign rsp
	mov	rax, 0x2000004		; write syscall
	syscall
	jnc	.done			; syscall errors set CF flag

	push	rax			; save errno value + align rsp
	call	___error		; get errno variable location
	pop	rdx			; restore errno value to rdx
	mov	dword [rax], edx	; set errno value
	xor	rax, rax
	dec	rax			; set rax to -1 to indicate an error
.done:
	pop	rbp
	ret
