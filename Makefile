.PHONY: all test clean

all: test shellcheck

test: test-negative test-positive

.PHONY: shellcheck
shellcheck:
	shellcheck *.sh

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
