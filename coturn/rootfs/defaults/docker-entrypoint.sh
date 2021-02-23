#!/bin/ash

# use non empty TURN_PUBLIC_IP variable, othervise set it dynamically.
[ -z "${TURN_PUBLIC_IP}" ] && export TURN_PUBLIC_IP=$(curl -4ks http://169.254.169.254/latest/meta-data/public-ipv4)
[ -z "${TURN_PUBLIC_IP}" ] && echo "ERROR: variable TURN_PUBLIC_IP is not set and can not be set dynamically!" && kill 1

exec turnserver -c /config/turnserver.conf \
--verbose \
--prod \
--listening-port=${TURN_PORT:-5349} \
--tls-listening-port=${TURN_PORT:-5349} \
--alt-listening-port=${TURN_PORT:-5349} \
--alt-tls-listening-port=${TURN_PORT:-5349} \
--external-ip=${TURN_PUBLIC_IP} \
--static-auth-secret=${TURN_SECRET} \
--realm=${TURN_REALM} \
--listening-ip=$(hostname -i) \
--cli-password=NotReallyCliUs3d \
--no-cli
