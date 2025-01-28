
# This is a Dockerfile for the jboss-eap-8-tech-preview/eap81-openjdk21-builder-openshift-rhel9:1.0.0.Beta image.


## START target image jboss-eap-8-tech-preview/eap81-openjdk21-builder-openshift-rhel9:1.0.0.Beta
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

###### START module 'jboss.container.maven.module:3.8'
###### \
        # Copy 'jboss.container.maven.module' module content
        COPY modules/jboss.container.maven.module /tmp/scripts/jboss.container.maven.module
        # Custom scripts from 'jboss.container.maven.module' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.maven.module/configure.sh" ]
###### /
###### END module 'jboss.container.maven.module:3.8'

###### START module 'jboss.container.maven:3.8.21'
###### \
        # Copy 'jboss.container.maven' module content
        COPY modules/jboss.container.maven /tmp/scripts/jboss.container.maven
        # Switch to 'root' user for package management for 'jboss.container.maven' module defined packages
        USER root
        # Install packages defined in the 'jboss.container.maven' module
        RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y maven-openjdk21 \
            && microdnf clean all \
            && rpm -q maven-openjdk21
        # Set 'jboss.container.maven' module defined environment variables
        ENV \
            JBOSS_CONTAINER_MAVEN_38_MODULE="/opt/jboss/container/maven/38/" \
            MAVEN_VERSION="3.8"
        # Custom scripts from 'jboss.container.maven' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.maven/configure.sh" ]
###### /
###### END module 'jboss.container.maven:3.8.21'

###### START module 'jboss.container.wildfly.dynamic-resources:2.0'
###### \
        # Copy 'jboss.container.wildfly.dynamic-resources' module content
        COPY modules/jboss.container.wildfly.dynamic-resources /tmp/scripts/jboss.container.wildfly.dynamic-resources
        # Custom scripts from 'jboss.container.wildfly.dynamic-resources' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.wildfly.dynamic-resources/install.sh" ]
###### /
###### END module 'jboss.container.wildfly.dynamic-resources:2.0'

###### START module 'jboss.container.s2i.core:9.0'
###### \
        # Copy 'jboss.container.s2i.core' module content
        COPY modules/jboss.container.s2i.core /tmp/scripts/jboss.container.s2i.core
        # Switch to 'root' user for package management for 'jboss.container.s2i.core' module defined packages
        USER root
        # Install packages defined in the 'jboss.container.s2i.core' module
        RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y findutils rsync \
            && microdnf clean all \
            && rpm -q findutils rsync
        # Set 'jboss.container.s2i.core' module defined environment variables
        ENV \
            JBOSS_CONTAINER_S2I_CORE_MODULE="/opt/jboss/container/s2i/core/" \
            S2I_SOURCE_DEPLOYMENTS_FILTER="*.jar quarkus-app"
        # Set 'jboss.container.s2i.core' module defined labels
        LABEL \
            io.openshift.s2i.destination="/tmp" \
            io.openshift.s2i.scripts-url="image:///usr/local/s2i" \
            org.jboss.container.deployments-dir="/deployments"
        # Custom scripts from 'jboss.container.s2i.core' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.s2i.core/configure.sh" ]
###### /
###### END module 'jboss.container.s2i.core:9.0'

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

###### START module 'jboss.container.maven.default:1.0'
###### \
        # Copy 'jboss.container.maven.default' module content
        COPY modules/jboss.container.maven.default /tmp/scripts/jboss.container.maven.default
        # Switch to 'root' user for package management for 'jboss.container.maven.default' module defined packages
        USER root
        # Install packages defined in the 'jboss.container.maven.default' module
        RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y findutils \
            && microdnf clean all \
            && rpm -q findutils
        # Set 'jboss.container.maven.default' module defined environment variables
        ENV \
            JBOSS_CONTAINER_MAVEN_DEFAULT_MODULE="/opt/jboss/container/maven/default/"
        # Custom scripts from 'jboss.container.maven.default' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.maven.default/configure.sh" ]
###### /
###### END module 'jboss.container.maven.default:1.0'

###### START module 'jboss.container.maven.s2i:1.0'
###### \
        # Copy 'jboss.container.maven.s2i' module content
        COPY modules/jboss.container.maven.s2i /tmp/scripts/jboss.container.maven.s2i
        # Switch to 'root' user for package management for 'jboss.container.maven.s2i' module defined packages
        USER root
        # Install packages defined in the 'jboss.container.maven.s2i' module
        RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y tar \
            && microdnf clean all \
            && rpm -q tar
        # Set 'jboss.container.maven.s2i' module defined environment variables
        ENV \
            JBOSS_CONTAINER_MAVEN_S2I_MODULE="/opt/jboss/container/maven/s2i"
        # Custom scripts from 'jboss.container.maven.s2i' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.maven.s2i/configure.sh" ]
###### /
###### END module 'jboss.container.maven.s2i:1.0'

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

###### START module 'jboss.container.wildfly.run:2.0'
###### \
###### /
###### END module 'jboss.container.wildfly.run:2.0'

###### START module 'jboss.container.wildfly.s2i.bash:2.0'
###### \
        # Copy 'jboss.container.wildfly.s2i.bash' module content
        COPY modules/jboss.container.wildfly.s2i.bash /tmp/scripts/jboss.container.wildfly.s2i.bash
        # Set 'jboss.container.wildfly.s2i.bash' module defined environment variables
        ENV \
            JBOSS_CONTAINER_WILDFLY_S2I_MODULE="/opt/jboss/container/wildfly/s2i"
        # Set 'jboss.container.wildfly.s2i.bash' module defined labels
        LABEL \
            io.openshift.s2i.scripts-url="image:///usr/local/s2i" \
            io.s2i.scripts-url="image:///usr/local/s2i"
        # Custom scripts from 'jboss.container.wildfly.s2i.bash' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.wildfly.s2i.bash/configure.sh" ]
###### /
###### END module 'jboss.container.wildfly.s2i.bash:2.0'

###### START module 'jboss.container.wildfly.s2i.legacy:2.0'
###### \
        # Copy 'jboss.container.wildfly.s2i.legacy' module content
        COPY modules/jboss.container.wildfly.s2i.legacy /tmp/scripts/jboss.container.wildfly.s2i.legacy
        # Set 'jboss.container.wildfly.s2i.legacy' module defined environment variables
        ENV \
            JBOSS_CONTAINER_WILDFLY_S2I_LEGACY_GALLEON_MODULE="/opt/jboss/container/wildfly/s2i/galleon" \
            S2I_SOURCE_DEPLOYMENTS_FILTER="*.war *.ear *.rar *.jar"
        # Custom scripts from 'jboss.container.wildfly.s2i.legacy' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.wildfly.s2i.legacy/configure.sh" ]
###### /
###### END module 'jboss.container.wildfly.s2i.legacy:2.0'

###### START module 'jboss.container.eap.s2i-eap.bash:1.0'
###### \
        # Copy 'jboss.container.eap.s2i-eap.bash' module content
        COPY modules/jboss.container.eap.s2i-eap.bash /tmp/scripts/jboss.container.eap.s2i-eap.bash
        # Custom scripts from 'jboss.container.eap.s2i-eap.bash' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.eap.s2i-eap.bash/configure.sh" ]
###### /
###### END module 'jboss.container.eap.s2i-eap.bash:1.0'

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

###### START image 'jboss-eap-8-tech-preview/eap81-openjdk21-builder-openshift-rhel9:1.0.0.Beta'
###### \
        # Switch to 'root' user for package management for 'jboss-eap-8-tech-preview/eap81-openjdk21-builder-openshift-rhel9' image defined packages
        USER root
        # Install packages defined in the 'jboss-eap-8-tech-preview/eap81-openjdk21-builder-openshift-rhel9' image
        RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y hostname jq vim-minimal unzip \
            && microdnf clean all \
            && rpm -q hostname jq vim-minimal unzip
        # Set 'jboss-eap-8-tech-preview/eap81-openjdk21-builder-openshift-rhel9' image defined environment variables
        ENV \
            IMAGE_NAME="jboss-eap-8-tech-preview/eap81-openjdk21-builder-openshift-rhel9" \
            IMAGE_VERSION="1.0.0.Beta" \
            PROVISIONING_MAVEN_PLUGIN_ARTIFACT_ID="eap-maven-plugin" \
            PROVISIONING_MAVEN_PLUGIN_GROUP_ID="org.jboss.eap.plugins" \
            PROVISIONING_MAVEN_PLUGIN_VERSION="2.0.0.Beta1-redhat-00002" \
            SSO_DEFAULT_PROVIDER_NAME="rh-sso"
        # Set 'jboss-eap-8-tech-preview/eap81-openjdk21-builder-openshift-rhel9' image defined labels
        LABEL \
            com.redhat.component="jboss-eap81-openjdk21-builder-openshift-container" \
            com.redhat.deployments-dir="/opt/server/standalone/deployments" \
            description="Red Hat JBoss Enterprise Application Platform 8.1 OpenShift S2I Builder image." \
            io.cekit.version="4.14.0" \
            io.k8s.description="Platform for building and running Jakarta EE applications on JBoss EAP 8.1" \
            io.k8s.display-name="JBoss EAP 8.1 S2I builder" \
            io.openshift.expose-services="8080:http" \
            io.openshift.s2i.scripts-url="image:///usr/local/s2i" \
            io.openshift.tags="builder,javaee,eap,eap8" \
            io.s2i.scripts-url="image:///usr/local/s2i" \
            maintainer="Red Hat" \
            name="jboss-eap-8-tech-preview/eap81-openjdk21-builder-openshift-rhel9" \
            org.jboss.product="eap81-openjdk21-builder" \
            org.jboss.product.version="1.0.0.Beta" \
            summary="Red Hat JBoss Enterprise Application Platform 8.1 OpenShift S2I Builder image."
        # Exposed ports in 'jboss-eap-8-tech-preview/eap81-openjdk21-builder-openshift-rhel9' image
        EXPOSE 8443 8080
###### /
###### END image 'jboss-eap-8-tech-preview/eap81-openjdk21-builder-openshift-rhel9:1.0.0.Beta'



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