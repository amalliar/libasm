;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_strdup.s                                        :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/16 00:53:32 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/23 17:45:13 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	; char	*ft_strdup(const char *s1);
	global	_ft_strdup
	extern	_ft_strlen
	extern	_ft_strcpy
	extern	_malloc
_ft_strdup:
	push	rdi			; save char *s1
	call	_ft_strlen		; rax is now the length of the string
	mov	rdi, rax		; size parameter for malloc
	inc	rdi			; one extra byte for '\0'
	call	_malloc
	pop	rsi			; restore char *s1 to rsi
	test	rax, rax		; check if malloc returned NULL
	jz	.done

	mov	rdi, rax		; dst is the newly allocated memory
	call	_ft_strcpy
.done:
	ret
