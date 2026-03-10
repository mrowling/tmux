#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $current_dir/utils.sh

main()
{
  # Call tmux-pomodoro-plus to get the current pomodoro status
  pomodoro_script="${HOME}/.tmux/plugins/tmux-pomodoro-plus/scripts/pomodoro.sh"
  
  if [ -f "$pomodoro_script" ]; then
    "$pomodoro_script"
  else
    echo "Pomodoro Not Found"
  fi
}

main
