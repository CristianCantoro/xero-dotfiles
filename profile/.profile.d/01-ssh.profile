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

  if pgrep -f ssh-agent > /dev/null && [ ! -z "${SSH_AUTH_SOCK}" ]; then
    num_processes="$(pgrep -f ssh-agent | wc -l)"
    if [ "$num_processes" -gt '1' ]; then
      (>&2 echo 'Multiple ssh-agent processes found. Exiting.' )
      return 1
    fi

    (
      umask 066
      cat << EOF > "$SSH_ENV"
SSH_AUTH_SOCK=$SSH_AUTH_SOCK; export SSH_AUTH_SOCK;
SSH_AGENT_PID=$(pgrep -f 'ssh-agent'); export SSH_AGENT_PID;
# echo Agent pid $(pgrep -f 'ssh-agent');
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
