# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: amalliar <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/09 23:55:29 by amalliar          #+#    #+#              #
#    Updated: 2021/09/22 19:42:12 by amalliar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SHELL      := /bin/sh
CC         := clang
ASM        := nasm -Wall
CFLAGS     := -Wall -Wextra -fdiagnostics-color -g -pipe
INCLUDE    := -I./include
AR         := ar -rcs
NAME       := libasm.a
SRCDIR     := src
OBJDIR     := .obj

SRCS       := src/ft_strlen.s \
              src/ft_strcpy.s \
              src/ft_strcmp.s \
              src/ft_write.s \
              src/ft_read.s \
              src/ft_strdup.s
OBJS       := $(SRCS:$(SRCDIR)/%.s=$(OBJDIR)/%.o)
BSRCS      := src/ft_strchr_bonus.s \
              src/ft_strisnonrepeat_bonus.s \
              src/ft_atoi_base_bonus.s \
              src/ft_create_elem_bonus.s \
              src/ft_list_push_front_bonus.s \
              src/ft_list_size_bonus.s \
              src/ft_list_sort_bonus.s \
              src/ft_list_remove_if_bonus.s
BOBJS      := $(BSRCS:$(SRCDIR)/%.s=$(OBJDIR)/%.o)

# Run multiple threads.
MAKEFLAGS  := -j 4 --output-sync=recurse --no-print-directory

# Define some colors for echo:
LGREEN     := \033[1;32m
WHITE      := \033[1;37m
NOC        := \033[0m

all: $(NAME)
$(NAME): $(OBJS)
	@echo -e "$(LGREEN)Linking static library $(NAME)$(NOC)"
	@$(AR) $@ $?
	@echo -e "Built target $(NAME)"
.PHONY: all

bonus: $(NAME) $(BOBJS)
	@echo -e "$(LGREEN)Adding bonus functions...$(NOC)"
	@$(AR) -u $(NAME) $(BOBJS)
	@echo -e "Updated target $(NAME)"
.PHONY: bonus

$(OBJDIR)/%.o: $(SRCDIR)/%.s | $(OBJDIR)
	$(ASM) -fmacho64 -o $@ $<
$(OBJDIR):
	@mkdir -p $(OBJDIR)

clean:
	@echo -e "$(WHITE)Removing object files...$(NOC)"
	@-rm -rf $(OBJDIR)
.PHONY: clean

fclean: clean
	@echo -e "$(WHITE)Removing static library $(NAME)$(NOC)"
	@-rm -f $(NAME)
.PHONY: fclean

re:
	$(MAKE) fclean MAKEFLAGS=
	$(MAKE) all MAKEFLAGS=
.PHONY: re

test: $(NAME)
	@echo -e "$(LGREEN)Building test executable...$(NOC)"
	@$(CC) $(CFLAGS) $(INCLUDE) src/main.c -L. -lasm -o test
	@echo -e "Built target test"
	@echo -e "> start\n"
	@./test &
	@sleep 1
	@-leaks test
	@killall test
	@echo -e "> done"
	@rm -f test
.PHONY: test

btest: $(NAME)
	@$(MAKE) bonus MAKEFLAGS=
	@echo -e "$(LGREEN)Building test executable...$(NOC)"
	@$(CC) $(CFLAGS) $(INCLUDE) -D TEST_BONUS_PART src/main.c -L. -lasm -o btest
	@echo -e "Built target btest"
	@echo -e "> start\n"
	@./btest &
	@sleep 2
	@-leaks btest
	@killall btest
	@echo -e "> done"
	@rm -f btest
.PHONY: btest

help:
	@echo -e "The following are some of the valid targets for this Makefile:"
	@echo -e "... all (the default if no target is provided)"
	@echo -e "... clean"
	@echo -e "... fclean"
	@echo -e "... re"
	@echo -e "... test"
	@echo -e "... btest"
.PHONY: help
