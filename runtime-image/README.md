
Build with podman:

* JDK17: `cekit --redhat build --overrides image-jdk17-overrides.yaml podman`
* JDK21: `cekit --redhat build --overrides image-jdk21-overrides.yaml podman`

Build with OSBS:

* JDK17: `cekit --redhat build --overrides image-jdk17-overrides.yaml --overrides rh-jdk17-overrides.yaml osbs`
* JDK21: `cekit --redhat build --overrides image-jdk21-overrides.yaml --overrides rh-jdk21-overrides.yaml osbs`