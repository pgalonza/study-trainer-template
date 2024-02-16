#!/usr/bin/env bash

export PROMPT_COMMAND='echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(whoami) $(history 1)" >> /course/commands-task.log'

glow /course/tasks/welcome.md
