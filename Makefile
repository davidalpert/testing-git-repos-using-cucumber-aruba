# Make is verbose in Linux. Make it silent.
MAKEFLAGS += --silent

# ---------------------- targets -------------------------------------

.PHONY: default
default: help

.PHONY: test
test: test-features ## run all tests

Gemfile.lock: Gemfile 
	bundle update

.PHONY: test-features
test-features: Gemfile.lock ## Run all cucumber/aruba backend features
	bundle exec cucumber --publish-quiet --tags 'not @wip' --tags 'not @ignore'

.PHONY: test-features-wip
test-features-wip: Gemfile.lock ## Run WIP cucumber/aruba backend features
	bundle exec cucumber --publish-quiet --tags '@wip' --tags 'not @ignore'

.PHONY: list-ignored
list-ignored: Gemfile.lock ## list ignored cucumber/aruba backend features
	bundle exec cucumber --publish-quiet --tags '@ignore' --dry-run

.PHONY: help
help: Makefile
	@echo
	@echo " available targets:"
	@echo
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo
