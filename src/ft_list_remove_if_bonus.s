;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_list_remove_if_bonus.s                          :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/21 10:00:27 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/22 10:18:29 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	; void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)());
	global	_ft_list_remove_if
	extern	_free
_ft_list_remove_if:
	test	rdi, rdi
	jz	.done			; if (begin_list != NULL && \

	test	rsi, rsi
	jz	.done			; data_ref != NULL && \

	test	rdx, rdx
	jz	.done			; cmp != NULL)

	push	rbp
	mov	rbp, rsp
	sub	rsp, 32			; four 8 byte vars + 8 bytes for proper alignment
	mov	[rbp - 8], rdi		; save nonvolatile register
	mov	[rbp - 16], rdx		; int (*cmp)()
	mov	[rbp - 24], rbx		; save nonvolatile register
	mov	[rbp - 32], rsi		; apparently some motherfucker breaks my rsi,
					; so I have to save it too!!
	mov	rbx, rdi		; t_list **begin_list -> rbx
.loop0:
	cmp	qword [rbx], 0
	je	.break0			; while (*begin_list && \

	mov	rdi, [rbx]		; *begin_list -> rdi
	mov	rdi, [rdi]		; (*begin_list)->data -> rdi
	mov	rsi, [rbp - 32]		; restore data_ref
	call	[rbp - 16]
	test	rax, rax
	jnz	.break0			; !cmp((*begin_list)->data, data_ref))

	mov	rdi, [rbx]		; *begin_list -> rdi
	mov	rdx, [rdi + 8]		; (*begin_list)->next -> rdx
	mov	[rbx], rdx		; *begin_list = (*begin_list)->next;
	call	_free
	jmp	.loop0
.break0:
	mov	rbx, [rbx]		; *begin_list -> rbx
.loop1:
	test	rbx, rbx
	jz	.break1			; while (tmp != NULL)
.loop2:
	cmp	qword [rbx + 8], 0
	je	.break2			; while (tmp->next && \

	mov	rdi, [rbx + 8]		; tmp->next -> rdi
	mov	rdi, [rdi]		; tmp->next->data -> rdi
	mov	rsi, [rbp - 32]		; restore data_ref
	call	[rbp - 16]
	test	rax, rax
	jnz	.break2			; !cmp(tmp->next->data, data_ref))

	mov	rdi, [rbx + 8]		; tmp->next -> rdi
	mov	rdx, [rdi + 8]		; tmp->next->next -> rdx
	mov	[rbx + 8], rdx		; tmp->next = tmp->next->next;
	call	_free
	jmp	.loop2
.break2:
	mov	rbx, [rbx + 8]		; tmp = tmp->next;
	jmp	.loop1
.break1:
	mov	rdi, [rbp - 8]		; restore nonvolatile register
	mov	rbx, [rbp - 24]		; restore nonvolatile register
	mov	rsp, rbp		; function epilogue
	pop	rbp
.done:
	ret
