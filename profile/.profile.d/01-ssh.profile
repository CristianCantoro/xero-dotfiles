#!/usr/bin/env bash

##############################################################################
# SSH

SSH_ENV="$HOME/.ssh/environment"

# ssh-add -l returns the error code 2 if it cannot connect to the agent:
#   $ ssh-add -l
#   Error connecting to agent: No such file or directory
#   $ echo $?
#   2
function ssh_agent_cant_connect() {
  ssh-add -l &>/dev/null
  if [ "$?" -eq '2' ]; then
    return 0
  else
    return 1
  fi
}

function ssh_agent_dump_env() {

  if [ ! -z "${SSH_AUTH_SOCK}" ]; then

    if pgrep -f ssh-agent > /dev/null; then
      num_processes="$(pgrep -f ssh-agent | wc -l)"
      if [ "$num_processes" -gt '1' ]; then
        (>&2 echo 'Error: multiple ssh-agent processes found. Exiting.' )
        return 1
      fi
    fi

    local agent_pid_flag
    local agent_pid

    agent_pid_flag=false
    agent_pid=$(echo "$SSH_AUTH_SOCK" | awk -F'.' '{print $NF}')
    if ! { [ -n "$agent_pid" ] && \
           [ "$agent_pid" -eq "$agent_pid" ] 2>/dev/null; }; then
      # not a number
      agent_pid_flag=false
      (>&2 echo 'Warning: ssh agent pid from SSH_AUTH_SOCK is not a number.' )
    else
      agent_pid_flag=true
    fi

    (
      umask 066
      cat << EOF > "$SSH_ENV"
SSH_AUTH_SOCK=$SSH_AUTH_SOCK; export SSH_AUTH_SOCK;
EOF

      if $agent_pid_flag; then
        cat << EOF >> "$SSH_ENV"
SSH_AGENT_PID=$agent_pid; export SSH_AGENT_PID;
EOF
      fi

      cat << EOF >> "$SSH_ENV"
# ssh-agent dumped on $(date --iso-8601=seconds).
EOF
    )

  else
    echo 'No ssh-agent process and SSH_AUTH_SOCK not set, nothing to do.'
    return 0
  fi
}

# if SSH_AUTH_SOCK is unset then the agent is not working for sure
if [ -z "${SSH_AUTH_SOCK+x}" ]; then

  if ssh_agent_cant_connect; then
    # activate ssh-agent on login
    # https://stackoverflow.com/a/18915067/2377454

    function start_ssh_agent() {
      echo 'Initialising new SSH agent...'

      # start agent and save environment in SSH_ENV
      (umask 066; ssh-agent | sed 's/^echo/# echo/' > "${SSH_ENV}")

      # source SSH_ENV
      # shellcheck disable=SC1090
      source "${SSH_ENV}" > /dev/null

      ssh-add
    }

    # Source SSH settings, if applicable
    if test -r "${SSH_ENV}" && [ -f "${SSH_ENV}" ]; then
      # shellcheck disable=SC1090
      source "${SSH_ENV}" > /dev/null
    fi

    # if ssh-agent is not running and SSH_AGENT_PID not set
    if ! pgrep -f ssh-agent > /dev/null && [ ! -z "${SSH_AGENT_PID}" ]; then
      start_ssh_agent
    fi
  fi

fi

# Run SSH with GPG support
# see:
# https://github.com/dainnilsson/scripts/blob/master/base-install/gpg.sh
# export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
