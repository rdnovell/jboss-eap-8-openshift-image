#!/bin/bash

echo "This script build and push the images to OpenShift cluster."
echo "Pre-requisites:"
echo " * You must be logged into the cluster"
echo " * You can push images to the 'openshift' project"
echo " * You have podman installed"
echo " * You have cekit installed (if the script detects that the images don't exist in the local repository)."


BUILDER_IMAGE_JDK21=eap81-openjdk21-builder-openshift-rhel9
BUILDER_IMAGE_JDK17=eap81-openjdk17-builder-openshift-rhel9
RUNTIME_IMAGE_JDK21=eap81-openjdk21-runtime-openshift-rhel9
RUNTIME_IMAGE_JDK17=eap81-openjdk17-runtime-openshift-rhel9

OC_PROJECT=openshift

oc project $OC_PROJECT

OPENSHIFT_NS=$(oc project -q)
OPENSHIFT_IMAGE_REGISTRY=$(oc registry info)
podman login --tls-verify=false -u openshift -p $(oc whoami -t) $OPENSHIFT_IMAGE_REGISTRY
echo "Logged in openshift registry $OPENSHIFT_IMAGE_REGISTRY"

podman inspect jboss-eap-8-tech-preview/$BUILDER_IMAGE_JDK21:latest > /dev/null
if [ "$?" == "0" ]; then
  echo "Images already exist, not building them."
else  
  echo "Images are not found, building the images..."
  cd builder-image
  cekit --redhat build --overrides image-jdk17-overrides.yaml podman
  cekit --redhat build --overrides image-jdk21-overrides.yaml podman

  cd ../runtime-image
  cekit --redhat build --overrides image-jdk17-overrides.yaml podman
  cekit --redhat build --overrides image-jdk21-overrides.yaml podman
fi

inspected=$(podman inspect jboss-eap-8-tech-preview/eap81-openjdk21-builder-openshift-rhel9:latest)
VERSION=$(echo $inspected | jq -r .[].Labels.version)
echo Image version is: $VERSION

echo Pushing the images...

podman tag jboss-eap-8-tech-preview/eap81-openjdk21-builder-openshift-rhel9:latest $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$BUILDER_IMAGE_JDK21:$VERSION
podman tag jboss-eap-8-tech-preview/eap81-openjdk21-builder-openshift-rhel9:latest $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$BUILDER_IMAGE_JDK21:latest
echo Pushing image $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$BUILDER_IMAGE_JDK21:$VERSION
podman push --tls-verify=false $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$BUILDER_IMAGE_JDK21:$VERSION
echo Pushing image $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$BUILDER_IMAGE_JDK21:latest
podman push --tls-verify=false $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$BUILDER_IMAGE_JDK21:latest

podman tag jboss-eap-8-tech-preview/eap81-openjdk17-builder-openshift-rhel9:latest $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$BUILDER_IMAGE_JDK17:$VERSION
podman tag jboss-eap-8-tech-preview/eap81-openjdk17-builder-openshift-rhel9:latest $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$BUILDER_IMAGE_JDK17:latest

echo Pushing image $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$BUILDER_IMAGE_JDK17:$VERSION
podman push --tls-verify=false $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$BUILDER_IMAGE_JDK17:$VERSION
echo Pushing image $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$BUILDER_IMAGE_JDK17:latest
podman push --tls-verify=false $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$BUILDER_IMAGE_JDK17:latest

podman tag jboss-eap-8-tech-preview/eap81-openjdk21-runtime-openshift-rhel9:latest $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$RUNTIME_IMAGE_JDK21:$VERSION
podman tag jboss-eap-8-tech-preview/eap81-openjdk21-runtime-openshift-rhel9:latest $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$RUNTIME_IMAGE_JDK21:latest

echo Pushing image $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$RUNTIME_IMAGE_JDK21:$VERSION
podman push --tls-verify=false $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$RUNTIME_IMAGE_JDK21:$VERSION
echo Pushing image $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$RUNTIME_IMAGE_JDK21:latest
podman push --tls-verify=false $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$RUNTIME_IMAGE_JDK21:latest

podman tag jboss-eap-8-tech-preview/eap81-openjdk17-runtime-openshift-rhel9:latest $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$RUNTIME_IMAGE_JDK17:$VERSION
podman tag jboss-eap-8-tech-preview/eap81-openjdk17-runtime-openshift-rhel9:latest $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$RUNTIME_IMAGE_JDK17:latest

echo Pushing image $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$RUNTIME_IMAGE_JDK17:$VERSION
podman push --tls-verify=false $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$RUNTIME_IMAGE_JDK17:$VERSION
echo Pushing image $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$RUNTIME_IMAGE_JDK17:latest
podman push --tls-verify=false $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$RUNTIME_IMAGE_JDK17:latest