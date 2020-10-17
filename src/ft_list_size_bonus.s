;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_list_size_bonus.s                               :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/17 09:31:13 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/17 09:43:35 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	global	_ft_list_size
_ft_list_size:
	xor	rax, rax		; count = 0
	test	rdi, rdi
	jz	.done			; begin_list == NULL
	
	mov	rdx, rdi		; move rdi to rdx to avoid unnecessary save/restore
.loop:
	inc	rax			; ++count
	mov	rdx, [rdx + 8]		; lst = lst->next
	test	rdx, rdx
	jnz	.loop			; while (lst != NULL)
.done:
	ret
