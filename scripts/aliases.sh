#!/usr/bin/env bash

DIRECTORY_TASKS="/course/tasks"
DIRECTORY_SCRIPTS="/course/scripts"
DIRECTORY_TESTS="/course/tasks-test"

function task()
{
    task_path="$DIRECTORY_TASKS/task-$1.md"
    script_path="$DIRECTORY_SCRIPTS/task-$1.sh"
    if [ -f "$task_path" ]; then
        glow $task_path
        TASK_STAGE="Task $1"
        export PS1="\[\033[38;5;42m\]$TASK_STAGE$(tput sgr0)\]\n\u@\h\W# "
        alias check="py.test --no-header $DIRECTORY_TESTS/test_task_$1.py"
        echo "<= $TASK_STAGE =>" >> /course/commands-task.log
    fi

    if [ -f "$script_path" ]; then
        $script_path
    fi

}
