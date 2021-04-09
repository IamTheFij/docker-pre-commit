# docker-pre-commit

A set of [pre-commit](http://pre-commit.com) hooks for Docker services

## Hooks

### docker-compose-check
Verifies that docker-compose files are valid by using `docker-compose config` to parse them.

### hadolint (Removed)
These hooks have been removed in favor of the ones that have been added to https://github.com/hadolint/hadolint
