;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_strdup.s                                        :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/16 00:53:32 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/16 01:52:25 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	global	_ft_strdup
	extern	_ft_strlen
	extern	_ft_strcpy
	extern	_malloc
_ft_strdup:
	sub	rsp, 24			; allocate space for locals + align rsp
	mov	[rsp + 8], rdi		; save nonvolatile register
	mov	[rsp], rsi		; save nonvolatile register
	call	_ft_strlen		; rax is now the length of the string

	mov	rdi, rax		; size parameter for malloc
	inc	rdi			; one extra byte for '\0'
	call	_malloc

	test	rax, rax		; check if malloc returned NULL
	jz	.done
	mov	rdi, rax		; dst is the newly allocated memory
	mov	rsi, [rsp + 8]		; src is the address of the original string
	call	_ft_strcpy
.done:
	mov	rdi, [rsp + 8]		; restore nonvolatile register
	mov	rsi, [rsp]		; restore nonvolatile register
	add	rsp, 24			; restore rsp
	ret
