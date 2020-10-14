# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: amalliar <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/09 23:55:29 by amalliar          #+#    #+#              #
#    Updated: 2020/10/14 04:43:55 by amalliar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SHELL      := /bin/sh
CC         := clang
ASM        := nasm
CFLAGS     := -Wall -Wextra -fdiagnostics-color -g -pipe
INCLUDE    := -I./include
AR         := ar -rcs
NAME       := libasm.a
SRCDIR     := src
OBJDIR     := .obj

SRCS       := src/ft_strlen.s \
              src/ft_strcpy.s \
              src/ft_strcmp.s
OBJS       := $(SRCS:$(SRCDIR)/%.s=$(OBJDIR)/%.o)

# Run multiple threads.
MAKEFLAGS  := -j 4 --output-sync=recurse --no-print-directory

# Define some colors for echo:
LGREEN     := \033[1;32m
WHITE      := \033[1;37m
NOC        := \033[0m

all: $(NAME)
$(NAME): $(OBJS)
	@echo "$(LGREEN)Linking static library $(NAME)$(NOC)"
	@$(AR) $@ $?
	@echo "Built target $(NAME)"
.PHONY: all

$(OBJDIR)/%.o: $(SRCDIR)/%.s | $(OBJDIR)
	$(ASM) -fmacho64 -o $@ $<
$(OBJDIR):
	@mkdir -p $(OBJDIR)

clean:
	@echo "$(WHITE)Removing object files...$(NOC)"
	@-rm -rf $(OBJDIR)
.PHONY: clean

fclean: clean
	@echo "$(WHITE)Removing static library $(NAME)$(NOC)"
	@-rm -f $(NAME)
.PHONY: fclean

re:
	$(MAKE) fclean MAKEFLAGS=
	$(MAKE) all MAKEFLAGS=
.PHONY: re

test: $(NAME)
	@echo "$(LGREEN)Building test executable...$(NOC)"
	@$(CC) $(CFLAGS) $(INCLUDE) -L. -lasm src/test.c -o test
	@echo "Built target test"
	@echo "> start\n"
	@./test && echo "\n> done"
	@rm -f test
.PHONY: test

help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... all (the default if no target is provided)"
	@echo "... clean"
	@echo "... fclean"
	@echo "... re"
	@echo "... test"
.PHONY: help
