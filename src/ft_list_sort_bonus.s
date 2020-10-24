;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   ft_list_sort_bonus.s                               :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2020/10/18 12:25:17 by amalliar          #+#    #+#             ;;
;;   Updated: 2020/10/24 10:24:03 by amalliar         ###   ########.fr       ;;
;;                                                                            ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;

	section	.text
	; void append(t_list **node, t_list **head, t_list **tail);
	global	_append
_append:
	; t_list **node -> rdi
	; t_list **head -> rsi
	; t_list **tail -> rdx

	mov	rax, [rdi]		; *node -> rax
	mov	rcx, [rax + 8]		; (*node)->next -> rcx
	cmp	qword [rsi], 0
	je	.init_list		; if (*head == NULL)

	mov	r8, [rdx]		; *tail -> r8
	mov	[r8 + 8], rax		; (*tail)->next = *node;
	mov	[rdx], rax		; *tail = *node;
	mov	[rdi], rcx		; *node = (*node)->next;
	mov	qword [rax + 8], 0	; (*tail)->next = NULL;
	ret
.init_list:
	mov	[rsi], rax		; *head = *node;
	mov	[rdx], rax		; *tail = *node;
	mov	[rdi], rcx		; *node = (*node)->next;
	mov	qword [rax + 8], 0	; (*tail)->next = NULL;
	ret


	section	.text
	; t_list *merge(t_list *list1_head, t_list *list2_head, int (*cmp)());
	global	_merge
_merge:
	push	rbp			; function prologue
	mov	rbp, rsp
	sub	rsp, 48			; 8 extra bytes for proper alignemnt
	mov	[rbp - 8], rdx		; int (*cmp)()
	mov	[rbp - 16], rdi		; t_list *list1_head
	mov	[rbp - 24], rsi		; t_list *list2_head
	mov	qword [rbp - 32], 0	; t_list *head = NULL;
	mov	qword [rbp - 40], 0	; t_list *tail = NULL;
.loop0:
	mov	rdi, [rbp - 16]		; list1_head -> rdi
	mov	rsi, [rbp - 24]		; list2_head -> rsi
	test	rdi, rdi
	jz	.break0			; while (list1_head != NULL && \

	test	rsi, rsi
	jz	.break0			; list2_head != NULL)
	
	mov	rdi, [rdi]		; list1_head->data -> rdi
	mov	rsi, [rsi]		; list2_head->data -> rsi
	call	[rbp - 8]		; cmp(list1_head->data, list2_head->data)
	cmp	rax, 0
	jge	.append_list2_head	; if (rax >= 0)

	lea	rdi, [rbp - 16]		; &list1_head -> rdi
	jmp	.append_list1_head
.append_list2_head:
	lea	rdi, [rbp - 24]		; &list2_head -> rdi
.append_list1_head:
	lea	rsi, [rbp - 32]		; &head -> rsi
	lea	rdx, [rbp - 40]		; &tail -> rdx
	call	_append			; append(&list[1|2]_head, &head, &tail);
	jmp	.loop0
.break0:
	cmp	qword [rbp - 16], 0
	jne	.loop1			; if (list1_head != NULL)

	mov	rax, [rbp - 24]		; list2_head -> rax
	mov	[rbp - 16], rax		; list1_head = list2_head;
.loop1:
	cmp	qword [rbp - 16], 0
	je	.break1			; while (list1_head != NULL)

	lea	rdi, [rbp - 16]		; &list1_head -> rdi
	lea	rsi, [rbp - 32]		; &head -> rsi
	lea	rdx, [rbp - 40]		; &tail -> rdx
	call	_append			; append(&list1_head, &head, &tail);
	jmp	.loop1
.break1:
	mov	rax, [rbp - 32]		; return (head);
	mov	rsp, rbp		; function epilogue
	pop	rbp
	ret


	section	.text
	; t_list *merge_sort(t_list *first, int (*cmp)());
	global	_merge_sort
_merge_sort:
	test	rdi, rdi
	jz	.done			; if (first == NULL || \

	cmp	qword [rdi + 8], 0
	je	.done			; first->next == NULL)

	push	rbp			; function prologue
	mov	rbp, rsp
	sub	rsp, 48
	mov	[rbp - 8], rsi		; int (*cmp)()
	mov	[rbp - 16], rdi		; t_list *first
	mov	qword [rbp - 24], 0	; t_list *list1_head = NULL;
	mov	qword [rbp - 32], 0	; t_list *list1_tail = NULL;
	mov	qword [rbp - 40], 0	; t_list *list2_head = NULL;
	mov	qword [rbp - 48], 0	; t_list *list2_tail = NULL;
.loop:
	cmp	qword [rbp - 16], 0
	je	.break			; while (first != NULL)

	lea	rdi, [rbp - 16]		; &first -> rdi
	lea	rsi, [rbp - 24]		; &list1_head -> rsi
	lea	rdx, [rbp - 32]		; &list1_tail -> rdx
	call	_append			; append(&first, &list1_head, &list1_tail);
	cmp	qword [rbp - 16], 0
	je	.break			; if (first != NULL)

	lea	rdi, [rbp - 16]		; &first -> rdi
	lea	rsi, [rbp - 40]		; &list2_head -> rsi
	lea	rdx, [rbp - 48]		; &list2_tail -> rdx
	call	_append
	jmp	.loop
.break:
	mov	rdi, [rbp - 24]		; list1_head -> rdi
	mov	rsi, [rbp - 8]		; cmp -> rsi
	call	_merge_sort
	mov	[rbp - 24], rax		; list1_head = merge_sort(list1_head, cmp);
	mov	rdi, [rbp - 40]		; list2_head -> rdi
	mov	rsi, [rbp - 8]		; cmp -> rsi
	call	_merge_sort
	mov	[rbp - 40], rax		; list2_head = merge_sort(list2_head, cmp);
	mov	rdi, [rbp - 24]		; list1_head -> rdi
	mov	rsi, [rbp - 40]		; list2_head -> rsi
	mov	rdx, [rbp - 8]		; cmp -> rdx
	call	_merge
	mov	rsp, rbp		; function epilogue
	pop	rbp
	ret
.done:
	mov	rax, rdi
	ret


	section	.text
	; void ft_list_sort(t_list **begin_list, int (*cmp)());
	global	_ft_list_sort
_ft_list_sort:
	test	rdi, rdi
	jz	.done			; if (!begin_list || \

	cmp	qword [rdi], 0
	je	.done			; !*begin_list);

	push	rdi			; save volatile register + realign rsp
	mov	rdi, [rdi]		; *begin_list -> rdi
	call	_merge_sort
	pop	rdi			; restore nonvolatile register
	mov	[rdi], rax		; *begin_list = merge_sort(*begin_list, cmp);
.done:
	ret
