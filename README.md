# docker-pre-commit

A set of [pre-commit](http://pre-commit.com) hooks for Docker services

## Hooks

### docker-compose-check
Verifies that docker-compose files are valid by using `docker-compose config` to parse them.

### hadolint
Uses the [hadolint Docker image](https://hub.docker.com/r/hadolint/hadolint) to lint Dockerfiles.

### hadolint-system
Uses the whatever version of hadolint that you have installed to lint Dockerfiles. This requires you to have hadolint installed somewhere in your path.
