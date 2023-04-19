# docker-pre-commit

A set of [pre-commit](http://pre-commit.com) hooks for Docker services

# Installation

Add the following to your `.pre-commit-config.yaml` file

```yaml
  - repo: https://github.com/iamthefij/docker-pre-commit
    rev: master
    hooks:
      - id: docker-compose-check
```

and then run `pre-commit autoupdate`.


## Hooks

### docker-compose-check
Verifies that docker-compose files are valid by using `docker-compose config` to parse them.
