/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/09 22:06:40 by amalliar          #+#    #+#             */
/*   Updated: 2020/10/14 04:15:38 by amalliar         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include "libasm.h"

#define	LGREEN	"\033[1;32m"
#define	NOC		"\033[0m"

void	test_ft_strlen(void);
void	test_ft_strcpy(void);
void	test_ft_strcmp(void);

int		main(void)
{
	test_ft_strlen();
	test_ft_strcpy();
	test_ft_strcmp();
	return (0);
}

void	test_ft_strlen(void)
{
	char	*buff;

	if (!(buff = malloc(1024)))
		exit(EXIT_FAILURE);
	printf("ft_strlen, random tests:\n");
	srand(time(NULL));
	for (int i = 0; i < 80; ++i)
	{
		memset(buff, 'f', 1024);
		buff[rand() % 1024] = '\0';
		assert(strlen(buff) == ft_strlen(buff));
		printf(LGREEN"+"NOC);
	}
	free(buff);
	printf("\nft_strlen, corner cases:\n");
	assert(strlen("") == ft_strlen(""));
	printf(LGREEN"+"NOC);
	assert(strlen("1") == ft_strlen("1"));
	printf(LGREEN"+"NOC"\n");
}

void	gen_cstring(char *buff, int size)
{
	int		i;

	for (i = 0; i < rand() % size; ++i)
		buff[i] = rand() % 127 + 1;
	buff[i] = '\0';
}

void	test_ft_strcpy(void)
{
	char	*dest1;
	char	*dest2;
	char	*src;

	if (!(dest1 = malloc(256)) || !(dest2 = malloc(256)) || !(src = malloc(256)))
		exit(EXIT_FAILURE);
	printf("\nft_strcpy, random tests:\n");
	for (int i = 0; i < 80; ++i)
	{
		memset(dest1, 'f', 256);
		memset(dest2, 'f', 256);
		gen_cstring(src, 256);
		strcpy(dest1, src);
		ft_strcpy(dest2, src);
		assert(!memcmp(dest1, dest2, 256));
		printf(LGREEN"+"NOC);
	}
	free(src);
	printf("\nft_strcpy, corner cases:\n");
	memset(dest1, 'f', 256);
	memset(dest2, 'f', 256);
	strcpy(dest1 + 10, "A");
	ft_strcpy(dest2 + 10, "A");
	assert(!memcmp(dest1, dest2, 256));
	printf(LGREEN"+"NOC);
	memset(dest1, 'f', 256);
	memset(dest2, 'f', 256);
	strcpy(dest1 + 10, "");
	ft_strcpy(dest2 + 10, "");
	assert(!memcmp(dest1, dest2, 256));
	printf(LGREEN"+"NOC"\n");
	free(dest1);
	free(dest2);
}

void	test_ft_strcmp(void)
{
	char	*str1;
	char	*str2;

	if (!(str1 = malloc(256)) || !(str2 = malloc(256)))
		exit(EXIT_FAILURE);
	printf("\nft_strcmp, random tests:\n");
	for (int i = 0; i < 80; ++i)
	{
		gen_cstring(str1, 256);
		(i % 4) ? memcpy(str2, str1, 256) : gen_cstring(str2, 256);
		assert(strcmp(str1, str2) == ft_strcmp(str1, str2));
		printf(LGREEN"+"NOC);
	}
	free(str1);
	free(str2);
	printf("\nft_strcmp, corner cases:\n");
	assert(strcmp("", "") == ft_strcmp("", ""));
	printf(LGREEN"+"NOC);
	assert((strcmp("1", "") > 0) && (ft_strcmp("1", "") > 0));
	printf(LGREEN"+"NOC);
	assert((strcmp("", "1") < 0) && (ft_strcmp("", "1") < 0));
	printf(LGREEN"+"NOC"\n");
}
