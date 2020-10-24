;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_list_remove_if_bonus.s                          :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/21 10:00:27 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/24 10:36:02 by amalliar         ###   ########.fr       ;;
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
	sub	rsp, 32			; 8 extra bytes for proper alignment
	mov	[rbp - 8], r12		; save nonvolatile register
	mov	[rbp - 16], r13		; save nonvolatile register
	mov	[rbp - 24], r14		; save nonvolatile register
	mov	r12, rdi		; t_list **begin_list -> r12
	mov	r13, rsi		; void *data_ref -> r13
	mov	r14, rdx		; int (*cmp)() -> r14
.loop0:
	cmp	qword [r12], 0
	je	.break0			; while (*begin_list && \

	mov	rdi, [r12]		; *begin_list -> rdi
	mov	rdi, [rdi]		; (*begin_list)->data -> rdi
	mov	rsi, r13		; data_ref -> rsi
	call	r14
	test	rax, rax
	jnz	.break0			; !cmp((*begin_list)->data, data_ref))

	mov	rdi, [r12]		; *begin_list -> rdi
	mov	rdx, [rdi + 8]		; (*begin_list)->next -> rdx
	mov	[r12], rdx		; *begin_list = (*begin_list)->next;
	call	_free
	jmp	.loop0
.break0:
	mov	r12, [r12]		; *begin_list -> rbx
.loop1:
	test	r12, r12
	jz	.break1			; while (tmp != NULL)
.loop2:
	cmp	qword [r12 + 8], 0
	je	.break2			; while (tmp->next && \

	mov	rdi, [r12 + 8]		; tmp->next -> rdi
	mov	rdi, [rdi]		; tmp->next->data -> rdi
	mov	rsi, r13		; data_ref -> rsi
	call	r14
	test	rax, rax
	jnz	.break2			; !cmp(tmp->next->data, data_ref))

	mov	rdi, [r12 + 8]		; tmp->next -> rdi
	mov	rdx, [rdi + 8]		; tmp->next->next -> rdx
	mov	[r12 + 8], rdx		; tmp->next = tmp->next->next;
	call	_free
	jmp	.loop2
.break2:
	mov	r12, [r12 + 8]		; tmp = tmp->next;
	jmp	.loop1
.break1:
	mov	r12, [rbp - 8]		; restore nonvolatile register
	mov	r13, [rbp - 16]		; restore nonvolatile register
	mov	r14, [rbp - 24]		; restore nonvolatile register
	mov	rsp, rbp		; function epilogue
	pop	rbp
.done:
	ret
