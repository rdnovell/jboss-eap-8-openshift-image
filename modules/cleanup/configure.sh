#!/bin/sh
# Configure module
set -e

ln -s "$JBOSS_HOME" /opt/eap

# Handle UBI9 specifics, otherwise cloud feature-pack for 8.0 would break
# Only create the link for UBI9 image.
if [ -n "${JBOSS_CONTAINER_JAVA_PROXY_MODULE}" ]; then
  if [ ! -f /opt/run-java/proxy-options ]; then
    mkdir -p /opt/run-java/
    ln -s "${JBOSS_CONTAINER_JAVA_PROXY_MODULE}/proxy-options" /opt/run-java/proxy-options
  fi
fi
