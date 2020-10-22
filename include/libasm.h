/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/09 22:08:31 by amalliar          #+#    #+#             */
/*   Updated: 2020/10/22 15:45:02 by amalliar         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H
# include <sys/types.h>
# include "ft_list.h"

char		*ft_strchr(const char *s, int c);
char		*ft_strcpy(char *dst, const char *src);
char		*ft_strdup(const char *s1);
int			ft_atoi_base(char *str, char *base);
int			ft_strcmp(const char *s1, const char *s2);
int			ft_strisnonrepeat(const char *s);
size_t		ft_strlen(const char *s);
ssize_t		ft_read(int fildes, void *buf, size_t nbyte);
ssize_t		ft_write(int fildes, const void *buf, size_t nbyte);
void		ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)());
void		ft_list_sort(t_list **begin_list, int (*cmp)());

#endif
