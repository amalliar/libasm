;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_list_push_front_bonus.s                         :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/17 08:20:03 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/17 08:58:10 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	global	_ft_list_push_front
	extern	_ft_create_elem
_ft_list_push_front:
	test	rdi, rdi		; check if begin_list == NULL
	jz	.done

	push	rdi			; save rdi + realign rsp
	mov	rdi, rsi		; data argument for ft_create_elem
	call	_ft_create_elem
	pop	rdi			; restore rdi
	test	rax, rax		; check if ft_create_elem returned NULL
	jz	.done

	mov	rdx, [rdi]
	test	rdx, rdx		; check if *begin_list == NULL
	jz	.lst_create		; list doesn't exist yet

	mov	[rax + 8], rdx		; elem->next = *begin_list
.lst_create:
	mov	[rdi], rax		; *begin_list = elem
.done:
	ret
