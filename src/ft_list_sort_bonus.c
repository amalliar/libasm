/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_sort_bonus.c                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/18 08:13:50 by amalliar          #+#    #+#             */
/*   Updated: 2020/10/21 08:16:06 by amalliar         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_list.h"

static void		append(t_list **node, t_list **head, t_list **tail)
{
	if (!*head)
	{
		*head = *node;
		*tail = *node;
		*node = (*node)->next;
		(*tail)->next = NULL;
		return ;
	}
	(*tail)->next = *node;
	*tail = *node;
	*node = (*node)->next;
	(*tail)->next = NULL;
}

static t_list	*merge(t_list *list1_head, t_list *list2_head, int (*cmp)())
{
	t_list	*head;
	t_list	*tail;

	head = NULL;
	tail = NULL;
	while (list1_head != NULL && list2_head != NULL)
	{
		if (cmp(list1_head->data, list2_head->data) < 0)
			append(&list1_head, &head, &tail);
		else
			append(&list2_head, &head, &tail);
	}
	if (list1_head == NULL)
		list1_head = list2_head;
	while (list1_head != NULL)
		append(&list1_head, &head, &tail);
	return (head);
}

static t_list	*merge_sort(t_list *first, int (*cmp)())
{
	t_list *list1_head;
	t_list *list1_tail;
	t_list *list2_head;
	t_list *list2_tail;

	list1_head = NULL;
	list1_tail = NULL;
	list2_head = NULL;
	list2_tail = NULL;
	if (first == NULL || first->next == NULL)
		return (first);
	while (first != NULL)
	{
		append(&first, &list1_head, &list1_tail);
		if (first != NULL)
			append(&first, &list2_head, &list2_tail);
	}
	list1_head = merge_sort(list1_head, cmp);
	list2_head = merge_sort(list2_head, cmp);
	return (merge(list1_head, list2_head, cmp));
}

void			ft_list_sort(t_list **begin_list, int (*cmp)())
{
	if (!begin_list || !*begin_list)
		return ;
	*begin_list = merge_sort(*begin_list, cmp);
}
