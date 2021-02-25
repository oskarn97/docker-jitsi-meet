#!/bin/sh

if [ $# -ne 7 ]; then
   echo "Usage:   $(basename $0) <public hostname> <public address> <homeserver name> <school number> <synapse admin token> <static turn secret> <ssl cert path> <ssl private key path>" 1>&2
   echo "Example: $(basename $0) 000016.logineonrw-2020.de 18.185.97.18 000016.nogineo.de 000016 ABCDEFGHIJKLMNOPQRSTUVWXYZB /root/cert.crt /root/cert.key"
   exit 1
fi

function random_key() {
   tr -cd '[:alnum:]' < /dev/random | dd bs=32 count=1 status=none 
}

function set_env_value() {
   if ! grep "^\\s*$1\\s*=" .env 1>/dev/null; then
      echo "$1=$2" >> .env
   else
      sed "s#\(\\s*$1\\s*=\\s*\).*#\1$2#" -i .env 
   fi
}

touch .env

set_env_value JICOFO_COMPONENT_SECRET $(random_key)
set_env_value JICOFO_AUTH_PASSWORD $(random_key)
set_env_value JVB_AUTH_PASSWORD $(random_key)
set_env_value JIGASI_XMPP_PASSWORD $(random_key)
set_env_value JIBRI_RECORDER_PASSWORD $(random_key)
set_env_value JIBRI_XMPP_PASSWORD $(random_key)
set_env_value TURN_SECRET $(random_key)
set_env_value TURN_HOST $1
set_env_value TURN_PUBLIC_IP $2
set_env_value UVS_HOMESERVER_URL https://$3
set_env_value UVS_ACCESS_TOKEN $5
set_env_value SSL_CERT $6
set_env_value SSL_PRIVATE_KEY $6
set_env_value SCHOOL_NO $7


