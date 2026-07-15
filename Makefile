DEFAULT_GOAL := help

.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: deps
deps: ## Install additional dependencies
	./tools/install-deps

.PHONY: install
install: ## Install Emacs configuration into the current system
	./tools/install

.PHONY: copy-lock
copy-lock: ## Copy lock from ~/.emacs.d to the repo
	cp ~/.emacs.d/straight/versions/default.el package-lock.el

.PHONY: test
test: ## Run unit tests
	emacs -Q --batch -L lisp $(foreach f,$(wildcard lisp/*-test.el),-l $(f)) -f ert-run-tests-batch-and-exit
