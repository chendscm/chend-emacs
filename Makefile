emacs ?= emacs

BASEDIR := $(shell pwd)

install: pull
	cd $(BASEDIR)
	make run

pull:
	echo "-*- mode: compilation -*-" > etc/log
	git pull 2>&1 | tee -a etc/log
	git submodule update --init --recursive 2>&1 | tee -a etc/log
	git submodule foreach git reset --hard 2>&1 | tee -a etc/log
	git submodule foreach git checkout master 2>&1 | tee -a etc/log

update:
	git submodule foreach git pull --rebase 2>&1 | tee -a etc/log

submodule: 
	git submodule update --init --recursive
	git submodule foreach git reset --hard
	git submodule foreach git checkout $(git remote show origin | awk '/HEAD 分支|HEAD branch/ {split($0, a, ":"); print a[2]}')

run:
	$(emacs) -Q -l init.el &

.PHONY: install run pull submodule
