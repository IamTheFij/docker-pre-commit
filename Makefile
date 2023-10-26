.PHONY: all test clean

all: check test

test: test-negative test-positive test-hooks

.PHONY: test-positive
test-positive:
	@echo "Check valid compose file."
	./compose-check.sh tests/docker-compose.yml || { echo 'fail'; exit 1; }

.PHONY: test-negative
test-negative:
	@echo "Check bad file. Should error."
	./compose-check.sh tests/docker-compose.bad.yml && { echo 'fail'; exit 1; } || echo 'ok'
	@echo "Check multiple files. Should error."
	./compose-check.sh tests/docker-compose* && { echo 'fail'; exit 1; } || echo 'ok'

.PHONY: test-hooks
test-hooks:
	pre-commit try-repo . --all-files

# Installs pre-commit hooks
.PHONY: install-hooks
install-hooks:
	pre-commit install --install-hooks

# Checks files for encryption
.PHONY: check
check:
	pre-commit run --all-files
