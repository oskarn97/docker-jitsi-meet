#!/bin/sh

function random_key() {
   tr -cd '[:alnum:]' < /dev/random | dd bs=32 count=1 status=none 
}

if [ $# -ne 7 ]; then 
   echo "Usage:   $(basename $0) <public hostname> <public address> <homeserver name> <school number> <synapse admin token> <static turn secret> <ssl cert path> <ssl private key path>" 1>&2
   echo "Example: $(basename $0) 000016.logineonrw-2020.de 18.185.97.18 000016.nogineo.de 000016 ABCDEFGHIJKLMNOPQRSTUVWXYZB /root/cert.crt /root/cert.key"
   exit 1
fi

cat <<EOD
JICOFO_COMPONENT_SECRET=$(random_key)
JICOFO_AUTH_PASSWORD=$(random_key)
JVB_AUTH_PASSWORD=$(random_key)
JIGASI_XMPP_PASSWORD=$(random_key)
JIBRI_RECORDER_PASSWORD=$(random_key)
JIBRI_XMPP_PASSWORD=$(random_key)

TURN_SECRET=$(random_key)
TURN_HOST=$1
TURN_PUBLIC_IP=$2

UVS_HOMESERVER_URL=https://$3
UVS_ACCESS_TOKEN=$5

SSL_CERT=$6
SSL_PRIVATE_KEY=$6

SCHOOL_NO=$4
EOD
