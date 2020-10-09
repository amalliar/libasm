/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/09 22:06:40 by amalliar          #+#    #+#             */
/*   Updated: 2020/10/09 22:34:31 by amalliar         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <assert.h>
#include <stdio.h>
#include <string.h>
#include "libasm.h"

int		main(void)
{
	printf("Starting ft_strlen tests...\n");
	assert(strlen("ABC") == ft_strlen("ABC"));
	return (0);
}
