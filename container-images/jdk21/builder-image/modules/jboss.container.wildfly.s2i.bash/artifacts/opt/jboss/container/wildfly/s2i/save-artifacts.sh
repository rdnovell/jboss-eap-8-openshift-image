#!/bin/sh

source "${JBOSS_CONTAINER_MAVEN_S2I_MODULE}/maven-s2i"

# initialize the module
maven_s2i_init

# persist the artifacts
maven_s2i_save_artifacts