# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: amalliar <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/09 23:55:29 by amalliar          #+#    #+#              #
#    Updated: 2020/10/09 22:21:00 by amalliar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SHELL      := /bin/sh
CC         := clang
ASM        := nasm
CFLAGS     := -Wall -Wextra -fdiagnostics-color -g -pipe
INCLUDE    := -I./include
AR         := ar -rcs
NAME       := libasm.a
OBJDIR     := .obj
DEPDIR     := .dep

SRCS       := src/ft_strlen.s
OBJS       := $(SRCS:%.c=$(OBJDIR)/%.o)
DEPS       := $(SRCS:%.c=$(DEPDIR)/%.d)

# Run multiple threads.
MAKEFLAGS  := -j 4 --output-sync=recurse --no-print-directory

# Protect against make incorrectly setting 'last modified' attribute 
# when running in parallel (-j flag).
POST_COMPILE = mv -f $(DEPDIR)/$*.tmp $(DEPDIR)/$*.d && touch $@

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

$(OBJDIR)/%.o: %.s $(DEPDIR)/%.d | $(OBJDIR) $(DEPDIR)
	$(ASM) -MMD -MF $(DEPDIR)/$*.tmp -c -o $@ $<
	@$(POST_COMPILE)
$(OBJDIR):
	@mkdir -p $(OBJDIR)
$(DEPDIR):
	@mkdir -p $(DEPDIR)
$(DEPDIR)/%.d: ;
.PRECIOUS: $(DEPDIR)/%.d

clean:
	@echo "$(WHITE)Removing object files...$(NOC)"
	@-rm -rf $(OBJDIR)
	@echo "$(WHITE)Removing dependency files...$(NOC)"
	@-rm -rf $(DEPDIR)
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
	@echo "> start"
	@./test && echo "> done"
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

# Do not include dependency files if the current goal is
# set to clean/fclean/re.
ifeq ($(findstring $(MAKECMDGOALS), clean fclean re),)
    -include $(DEPS)
endif
