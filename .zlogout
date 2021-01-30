## SERVERS ##
# SSH Agent
# closes main processes SSH Agent's process
# SSH_AUTH_SOCK will still be set to the same random file after exit
# this gets reset on each launchd startup (e.g. when you restart your machine)
if [ -n "$SSH_AUTH_SOCK" ] ; then
  if [ -z "$TMUX" ] ; then
    SSH_AGENT_PID=$(launchctl list | grep com.openssh.ssh-agent | awk '{print $1;}')
	  eval `ssh-agent -k`
  fi
  echo "bye"
fi
