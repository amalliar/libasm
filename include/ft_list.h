/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list.h                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/17 09:08:53 by amalliar          #+#    #+#             */
/*   Updated: 2020/10/23 18:38:09 by amalliar         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef FT_LIST_H
# define FT_LIST_H

typedef struct		s_list
{
	void			*data;
	struct s_list	*next;
}					t_list;

int					ft_list_size(t_list *begin_list);
t_list				*ft_create_elem(void *data);
void				ft_list_push_front(t_list **begin_list, void *data);
void				ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)());
void				ft_list_sort(t_list **begin_list, int (*cmp)());

#endif
