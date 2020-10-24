;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_list_size_bonus.s                               :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/17 09:31:13 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/23 19:43:05 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	; int	ft_list_size(t_list *begin_list);
	global	_ft_list_size
_ft_list_size:
	xor	rax, rax		; count = 0;
	test	rdi, rdi
	jz	.done			; if (!begin_list)
.loop:
	inc	rax			; ++count;
	mov	rdi, [rdi + 8]		; lst = lst->next;
	test	rdi, rdi
	jnz	.loop			; while (lst != NULL)
.done:
	ret
