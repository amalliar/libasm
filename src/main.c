/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: amalliar <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/09 22:06:40 by amalliar          #+#    #+#             */
/*   Updated: 2020/10/17 09:48:30 by amalliar         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/types.h>
#include "libasm.h"

#define	LGREEN	"\033[1;32m"
#define	NOC		"\033[0m"

void	test_ft_strlen(void);
void	test_ft_strcpy(void);
void	test_ft_strcmp(void);
void	test_ft_write(void);
void	test_ft_read(void);
void	test_ft_strdup(void);
void	test_ft_strchr(void);
void	test_ft_strisunique(void);
void	test_ft_atoi_base(void);
void	test_ft_list_push_front(void);
void	test_ft_list_size(void);

int		main(void)
{
	test_ft_strlen();
	test_ft_strcpy();
	test_ft_strcmp();
	test_ft_write();
	test_ft_read();
	test_ft_strdup();

#ifdef TEST_BONUS_PART
	test_ft_strchr();
	test_ft_strisunique();
	test_ft_atoi_base();
	test_ft_list_push_front();
	test_ft_list_size();
#endif

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
	int		len;

	len = rand() % size;
	for (int i = 0; i < len; ++i)
		buff[i] = rand() % 255 + 1;
	buff[len] = '\0';
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

void	test_ft_write(void)
{
	int			fd;
	int			old_errno;
	ssize_t		slen;

	printf("\nft_write, functional tests:\n");
	slen = sizeof("This string is written to stdout.\n");
	assert(ft_write(STDOUT_FILENO, "This string is written to stdout.\n", slen) == slen);
	assert(ft_write(STDERR_FILENO, "This string is written to stderr.\n", slen) == slen);
	slen = sizeof("");
	assert(ft_write(STDOUT_FILENO, "", slen) == slen);
	printf(LGREEN"+++"NOC"\n");
	printf("ft_write, error handling:\n");
	write(255, "test", 4);
	old_errno = errno;
	errno = 0;
	assert(ft_write(255, "test", 4) == -1 && errno == old_errno);
	printf(LGREEN"+"NOC);
	if (!(fd = open("./src/test.c", O_RDONLY)))
		exit(EXIT_FAILURE);
	write(fd, "test", 4);
	old_errno = errno;
	errno = 0;
	assert(ft_write(fd, "test", 4) == -1 && errno == old_errno);
	printf(LGREEN"+"NOC"\n");
	close(fd);
}

void	test_ft_read(void)
{
	int		fd1;
	int		fd2;
	int		old_errno;
	char	*buff1;
	char	*buff2;

	if (!(fd1 = open("./src/test.c", O_RDONLY)) || !(fd2 = open("./src/test.c", O_RDONLY)) || \
		!(buff1 = calloc(128, 1)) || !(buff2 = calloc(128, 1)))
		exit(EXIT_FAILURE);
	printf("\nft_read, random tests:\n");
	for (int i = 0; i < 80; ++i)
	{
		assert(read(fd1, buff1, i) == ft_read(fd2, buff2, i));
		assert(!memcmp(buff1, buff2, 128));
		printf(LGREEN"+"NOC);
	}
	close(fd1);
	close(fd2);
	printf("\nft_read, error handling:\n");
	read(255, buff1, 4);
	old_errno = errno;
	errno = 0;
	assert(ft_read(255, buff2, 4) == -1 && errno == old_errno);
	printf(LGREEN"+"NOC);
	if (!(fd1 = open("./src/test.c", O_WRONLY)))
		exit(EXIT_FAILURE);
	read(fd1, buff1, 4);
	old_errno = errno;
	errno = 0;
	assert(ft_read(fd1, buff2, 4) == -1 && errno == old_errno);
	printf(LGREEN"+"NOC"\n");
	close(fd1);
	free(buff1);
	free(buff2);
}

void	test_ft_strdup(void)
{
	char	*src;
	char	*copy;

	if (!(src = malloc(256)))
		exit(EXIT_FAILURE);
	printf("\nft_strdup, random tests:\n");
	for (int i = 0; i < 80; ++i)
	{
		gen_cstring(src, 256);
		copy = ft_strdup(src);
		assert(!strcmp(src, copy));
		free(copy);
		printf(LGREEN"+"NOC);
	}
	printf("\n");
}

#ifdef TEST_BONUS_PART

void	test_ft_strchr(void)
{
	char	*str;
	char	c;

	if (!(str = malloc(256)))
		exit(EXIT_FAILURE);
	printf("\nft_strchr, random tests:\n");
	for (int i = 0; i < 80; ++i)
	{
		c = rand() % 256;
		gen_cstring(str, 256);
		assert(strchr(str, c) == ft_strchr(str, c));
		printf(LGREEN"+"NOC);
	}
	free(str);
	printf("\nft_strchr, null-terminator test:\n");
	assert(strchr("just some text...", 0) == ft_strchr("just some text...", 0));
	printf(LGREEN"+"NOC"\n");
}

void	test_ft_strisunique(void)
{
	printf("\nft_strisunique, functional tests:\n");
	assert(ft_strisunique("abcdefghijkl") == 1);
	printf(LGREEN"+"NOC);
	assert(ft_strisunique("") == 1);
	printf(LGREEN"+"NOC);
	assert(ft_strisunique("aAbBcC") == 1);
	printf(LGREEN"+"NOC);
	assert(ft_strisunique("abcida") == 0);
	printf(LGREEN"+"NOC);
	assert(ft_strisunique("albÿiw") == 1);
	printf(LGREEN"+"NOC);
	assert(ft_strisunique("albÿiwÿ") == 0);
	printf(LGREEN"+"NOC);
	assert(ft_strisunique("aldiwkÿsdÿ") == 0);
	printf(LGREEN"+"NOC);
	assert(ft_strisunique("\t‰~þ") == 1);
	printf(LGREEN"+"NOC"\n");
}

void	test_ft_atoi_base(void)
{
	int		num;
	int		base;
	char	*buff;
	char	*base8 = "01234567";
	char	*base10 = "0123456789";
	char	*base16 = "0123456789abcdef";

	printf("\nft_atoi_base, error handling:\n");
	assert(ft_atoi_base("", "0123456789") == 0);
	printf(LGREEN"+"NOC);
	assert(ft_atoi_base("255", "") == 0);
	printf(LGREEN"+"NOC);
	assert(ft_atoi_base("255", "2") == 0);
	printf(LGREEN"+"NOC);
	assert(ft_atoi_base("1012", "01") == 0);
	printf(LGREEN"+"NOC);
	assert(ft_atoi_base("101", "001") == 0);
	printf(LGREEN"+"NOC);
	assert(ft_atoi_base("101", "01+") == 0);
	printf(LGREEN"+"NOC);
	assert(ft_atoi_base("101", "01-") == 0);
	printf(LGREEN"+"NOC);
	assert(ft_atoi_base("2147483648", "0123456789") == 0);
	printf(LGREEN"+"NOC);
	assert(ft_atoi_base("-2147483649", "0123456789") == 0);
	printf(LGREEN"+"NOC);
	printf("\nft_atoi_base, random tests:\n");
	if (!(buff = malloc(64)))
		exit(EXIT_FAILURE);
	for (int i = 0; i < 80; ++i)
	{
		num = rand();
		base = (num % 2) ? 16 : (num % 3) ? 8 : 10;
		if (num % 20)
			num = 0;
		if (base == 10)
			num = -num;
		snprintf(buff, 64, (base == 16) ? "%x" : (base == 8) ? "%o" : "%+d", num);
		if (base == 8)
			assert(ft_atoi_base(buff, base8) == num);
		else if (base == 10)
			assert(ft_atoi_base(buff, base10) == num);
		else if (base == 16)
			assert(ft_atoi_base(buff, base16) == num);
		printf(LGREEN"+"NOC);
	}
	printf("\n");
	free(buff);
}

void	test_ft_list_push_front(void)
{
	t_list	*lst;

	printf("\nft_list_push_front, functional tests:\n");
	ft_list_push_front(&lst, "[0]: First line...\n");
	ft_list_push_front(&lst, "[1]: Second line...\n");
	ft_list_push_front(&lst, "[2]: Third line...\n");
	ft_list_push_front(&lst, "[3]: Fourth line...\n");
	ft_list_push_front(&lst, "[4]: Fifth line...\n");
	assert(!strcmp(lst->data, "[4]: Fifth line...\n"));
	printf(LGREEN"+"NOC);
	assert(!strcmp(lst->next->data, "[3]: Fourth line...\n"));
	printf(LGREEN"+"NOC);
	assert(!strcmp(lst->next->next->data, "[2]: Third line...\n"));
	printf(LGREEN"+"NOC);
	assert(!strcmp(lst->next->next->next->data, "[1]: Second line...\n"));
	printf(LGREEN"+"NOC);
	assert(!strcmp(lst->next->next->next->next->data, "[0]: First line...\n"));
	printf(LGREEN"+"NOC"\n");
	free(lst->next->next->next->next);
	free(lst->next->next->next);
	free(lst->next->next);
	free(lst->next);
	free(lst);
}

void	test_ft_list_size(void)
{
	t_list	*lst = NULL;

	printf("\nft_list_size, functional tests:\n");
	assert(ft_list_size(lst) == 0);
	printf(LGREEN"+"NOC);
	ft_list_push_front(&lst, "[0]: First line...\n");
	assert(ft_list_size(lst) == 1);
	printf(LGREEN"+"NOC);
	ft_list_push_front(&lst, "[1]: Second line...\n");
	assert(ft_list_size(lst) == 2);
	printf(LGREEN"+"NOC);
	ft_list_push_front(&lst, "[2]: Third line...\n");
	assert(ft_list_size(lst) == 3);
	printf(LGREEN"+"NOC);
	ft_list_push_front(&lst, "[3]: Fourth line...\n");
	assert(ft_list_size(lst) == 4);
	printf(LGREEN"+"NOC);
	ft_list_push_front(&lst, "[4]: Fifth line...\n");
	assert(ft_list_size(lst) == 5);
	printf(LGREEN"+"NOC"\n");
	free(lst->next->next->next->next);
	free(lst->next->next->next);
	free(lst->next->next);
	free(lst->next);
	free(lst);
}

#endif
