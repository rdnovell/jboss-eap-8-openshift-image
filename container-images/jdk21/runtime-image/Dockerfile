
# This is a Dockerfile for the jboss-eap-8-tech-preview/eap81-openjdk21-runtime-openshift-rhel9:1.0.0.Beta image.


## START target image jboss-eap-8-tech-preview/eap81-openjdk21-runtime-openshift-rhel9:1.0.0.Beta
## \
    FROM registry.access.redhat.com/ubi9/ubi-minimal


    USER root

###### START module 'jboss.container.user:2.0+jboss1'
###### \
        # Copy 'jboss.container.user' module content
        COPY modules/jboss.container.user /tmp/scripts/jboss.container.user
        # Switch to 'root' user for package management for 'jboss.container.user' module defined packages
        USER root
        # Install packages defined in the 'jboss.container.user' module
        RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y shadow-utils \
            && microdnf clean all \
            && rpm -q shadow-utils
        # Set 'jboss.container.user' module defined environment variables
        ENV \
            GECOS="JBoss user" \
            HOME="/home/jboss" \
            UID="185" \
            USER="jboss"
        # Custom scripts from 'jboss.container.user' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.user/configure.sh" ]
###### /
###### END module 'jboss.container.user:2.0+jboss1'

###### START module 'jboss.container.openjdk:0'
###### \
###### /
###### END module 'jboss.container.openjdk:0'

###### START module 'jboss.container.openjdk.jdk:21'
###### \
        # Copy 'jboss.container.openjdk.jdk' module content
        COPY modules/jboss.container.openjdk.jdk /tmp/scripts/jboss.container.openjdk.jdk
        # Switch to 'root' user for package management for 'jboss.container.openjdk.jdk' module defined packages
        USER root
        # Install packages defined in the 'jboss.container.openjdk.jdk' module
        RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y java-21-openjdk-devel \
            && microdnf clean all \
            && rpm -q java-21-openjdk-devel
        # Set 'jboss.container.openjdk.jdk' module defined environment variables
        ENV \
            JAVA_HOME="/usr/lib/jvm/java-21" \
            JAVA_VENDOR="openjdk" \
            JAVA_VERSION="21" \
            JBOSS_CONTAINER_OPENJDK_JDK_MODULE="/opt/jboss/container/openjdk/jdk"
        # Set 'jboss.container.openjdk.jdk' module defined labels
        LABEL \
            org.jboss.product="openjdk" \
            org.jboss.product.openjdk.version="21" \
            org.jboss.product.version="21"
        # Custom scripts from 'jboss.container.openjdk.jdk' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.openjdk.jdk/configure.sh" ]
###### /
###### END module 'jboss.container.openjdk.jdk:21'

###### START module 'jboss.container.wildfly.dynamic-resources:2.0'
###### \
        # Copy 'jboss.container.wildfly.dynamic-resources' module content
        COPY modules/jboss.container.wildfly.dynamic-resources /tmp/scripts/jboss.container.wildfly.dynamic-resources
        # Custom scripts from 'jboss.container.wildfly.dynamic-resources' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.wildfly.dynamic-resources/install.sh" ]
###### /
###### END module 'jboss.container.wildfly.dynamic-resources:2.0'

###### START module 'jboss.container.java.proxy:2.0'
###### \
        # Copy 'jboss.container.java.proxy' module content
        COPY modules/jboss.container.java.proxy /tmp/scripts/jboss.container.java.proxy
        # Set 'jboss.container.java.proxy' module defined environment variables
        ENV \
            JBOSS_CONTAINER_JAVA_PROXY_MODULE="/opt/jboss/container/java/proxy"
        # Custom scripts from 'jboss.container.java.proxy' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.java.proxy/configure.sh" ]
###### /
###### END module 'jboss.container.java.proxy:2.0'

###### START module 'jboss.container.java.jvm:1.0'
###### \
        # Copy 'jboss.container.java.jvm' module content
        COPY modules/jboss.container.java.jvm /tmp/scripts/jboss.container.java.jvm
        # Set 'jboss.container.java.jvm' module defined environment variables
        ENV \
            JBOSS_CONTAINER_JAVA_JVM_MODULE="/opt/jboss/container/java/jvm"
        # Custom scripts from 'jboss.container.java.jvm' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.java.jvm/configure.sh" ]
###### /
###### END module 'jboss.container.java.jvm:1.0'

###### START module 'jboss.container.wildfly.run.api:1.0'
###### \
###### /
###### END module 'jboss.container.wildfly.run.api:1.0'

###### START module 'jboss.container.wildfly.run.common:1.0'
###### \
        # Copy 'jboss.container.wildfly.run.common' module content
        COPY modules/jboss.container.wildfly.run.common /tmp/scripts/jboss.container.wildfly.run.common
        # Set 'jboss.container.wildfly.run.common' module defined environment variables
        ENV \
            JBOSS_CONTAINER_WILDFLY_RUN_MODULE="/opt/jboss/container/wildfly/run" \
            WILDFLY_OVERRIDING_ENV_VARS="1"
        # Custom scripts from 'jboss.container.wildfly.run.common' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.wildfly.run.common/configure.sh" ]
###### /
###### END module 'jboss.container.wildfly.run.common:1.0'

###### START module 'jboss.container.util.logging:1.0'
###### \
        # Copy 'jboss.container.util.logging' module content
        COPY modules/jboss.container.util.logging /tmp/scripts/jboss.container.util.logging
        # Set 'jboss.container.util.logging' module defined environment variables
        ENV \
            JBOSS_CONTAINER_UTIL_LOGGING_MODULE="/opt/jboss/container/util/logging/"
        # Custom scripts from 'jboss.container.util.logging' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.util.logging/configure.sh" ]
###### /
###### END module 'jboss.container.util.logging:1.0'

###### START module 'jboss.container.wildfly.run:2.0'
###### \
###### /
###### END module 'jboss.container.wildfly.run:2.0'

###### START module 'jboss.container.eap.cleanup:1.0'
###### \
        # Copy 'jboss.container.eap.cleanup' module content
        COPY modules/jboss.container.eap.cleanup /tmp/scripts/jboss.container.eap.cleanup
        # Set 'jboss.container.eap.cleanup' module defined environment variables
        ENV \
            JBOSS_HOME="/opt/server"
        # Custom scripts from 'jboss.container.eap.cleanup' module
        USER 185
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.eap.cleanup/configure.sh" ]
###### /
###### END module 'jboss.container.eap.cleanup:1.0'

###### START module 'jboss.container.util.pkg-update:1.0'
###### \
        # Copy 'jboss.container.util.pkg-update' module content
        COPY modules/jboss.container.util.pkg-update /tmp/scripts/jboss.container.util.pkg-update
        # Custom scripts from 'jboss.container.util.pkg-update' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.util.pkg-update/execute.sh" ]
###### /
###### END module 'jboss.container.util.pkg-update:1.0'

###### START image 'jboss-eap-8-tech-preview/eap81-openjdk21-runtime-openshift-rhel9:1.0.0.Beta'
###### \
        # Switch to 'root' user for package management for 'jboss-eap-8-tech-preview/eap81-openjdk21-runtime-openshift-rhel9' image defined packages
        USER root
        # Install packages defined in the 'jboss-eap-8-tech-preview/eap81-openjdk21-runtime-openshift-rhel9' image
        RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y hostname jq vim-minimal unzip tar \
            && microdnf clean all \
            && rpm -q hostname jq vim-minimal unzip tar
        # Set 'jboss-eap-8-tech-preview/eap81-openjdk21-runtime-openshift-rhel9' image defined environment variables
        ENV \
            IMAGE_NAME="jboss-eap-8-tech-preview/eap81-openjdk21-runtime-openshift-rhel9" \
            IMAGE_VERSION="1.0.0.Beta" \
            SSO_DEFAULT_PROVIDER_NAME="rh-sso"
        # Set 'jboss-eap-8-tech-preview/eap81-openjdk21-runtime-openshift-rhel9' image defined labels
        LABEL \
            com.redhat.component="jboss-eap81-openjdk21-runtime-openshift-container" \
            com.redhat.deployments-dir="/opt/server/standalone/deployments" \
            description="The JBoss EAP 8.1 OpenJDK 21 runtime image" \
            io.cekit.version="4.14.0" \
            io.k8s.description="Base image to run an EAP 8.1 server and application" \
            io.k8s.display-name="JBoss EAP 8.1 runtime image" \
            io.openshift.expose-services="8080:http" \
            io.openshift.tags="javaee,eap,eap8" \
            maintainer="Red Hat" \
            name="jboss-eap-8-tech-preview/eap81-openjdk17-runtime-openshift-rhel9" \
            org.jboss.product="eap81-openjdk21-runtime" \
            org.jboss.product.version="1.0.0.Beta" \
            summary="The JBoss EAP 8.1 OpenJDK 21 runtime image"
        # Exposed ports in 'jboss-eap-8-tech-preview/eap81-openjdk21-runtime-openshift-rhel9' image
        EXPOSE 8443 8080
###### /
###### END image 'jboss-eap-8-tech-preview/eap81-openjdk21-runtime-openshift-rhel9:1.0.0.Beta'



    # Switch to 'root' user and remove artifacts and modules
    USER root
    RUN rm -rf "/tmp/scripts" "/tmp/artifacts"
    # Clear package manager metadata
    RUN rm -rf "/var/cache/yum" "/var/lib/dnf" "/var/cache/apt" "/var/cache/dnf"

    # Define the user
    USER 185
    # Define the working directory
    WORKDIR /home/jboss
    # Define run cmd
    CMD ["sh", "-c", "${JBOSS_CONTAINER_WILDFLY_RUN_MODULE}/run"]
## /
## END target image