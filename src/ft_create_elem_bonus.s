;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_create_elem_bonus.s                             :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/17 08:58:55 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/23 18:44:35 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	;t_list	*ft_create_elem(void *data);
	global	_ft_create_elem
	extern	_malloc
_ft_create_elem:
	push	rdi			; save rdi + realign rsp
	mov	rdi, 16			; size argument for malloc
	call	_malloc
	pop	rdi			; restore rdi
	test	rax, rax		; check if malloc returned NULL
	jz	.done

	mov	qword [rax], rdi	; elem->data = data
	mov	qword [rax + 8], 0	; elem->next = NULL
.done:
	ret
	
