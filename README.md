[![Coverage Status](https://coveralls.io/repos/github/codi-hacks/space-race/badge.svg?branch=)](https://coveralls.io/github/codi-hacks/space-race?branch=)

# Spaceship Game!

Use w/a/s/d to move laterally via velocity. Press shift and arrow keys to "teleport" laterally.

Use `a`/`d` to spin the ship left/right and `w`/`s` to boost forward/backward. Press `space` to brake.

Press `b` for debug information.

Press `p` to pause.

## Running

Install [love2D](https://love2d.org/) and run `love .` in the main directory. That's it!

Of course, this game is still in development, so please expect bugs.

## Development

### Linting

You can check your changes against the linter in realtime by install the luacheck plugin for your editor or running `luacheck .` command (assuming you have luacheck installed).

### Docker

Alternatively, you can run the linter as well as the unit tests (via buster) if you have Docker installed.
Once docker is installed and running, simply invoke one of the `make` commands:

```sh
make test  # Run linter and unit tests
make test-lint  # Just luacheck
make test-unit  # Just busted
```
