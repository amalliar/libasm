/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/09 22:08:31 by amalliar          #+#    #+#             */
/*   Updated: 2020/10/17 02:31:21 by amalliar         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H
# include <sys/types.h>

size_t		ft_strlen(const char *s);
char 		*ft_strcpy(char * dst, const char * src);
int			ft_strcmp(const char *s1, const char *s2);
int			ft_strisunique(const char *s);
int			ft_atoi_base(char *str, char *base);
ssize_t		ft_write(int fildes, const void *buf, size_t nbyte);
ssize_t		ft_read(int fildes, void *buf, size_t nbyte);
char		*ft_strdup(const char *s1);
char		*ft_strchr(const char *s, int c);

#endif
