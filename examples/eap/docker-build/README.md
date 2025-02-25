# Building an EAP 8.1 application image using docker

In this example we are making use of the EAP 8.1 runtime image to build an EAP 8.1 server + JAX-RS application docker image.
In order to create an EAP 8 server containing our application, we are using the [EAP Maven Plugin](https://github.com/jbossas/eap-maven-plugin).

The docker image is built then deployed on an Openshift cluster using Helm charts for EAP 8.1.

# Use-cases

* Test EAP 8.1 new features and/or bug fixes on Openshift.

# EAP 8 Maven plugin configuration

High level view of the EAP Maven plugin configuration.

## Galleon feature-packs

* `org.jboss.eap:wildfly-ee-galleon-pack`
* `org.jboss.eap.cloud:eap-cloud-galleon-pack`

## Galleon layers

* `jaxrs-server`

## CLI scripts

JBoss EAP CLI scripts executed at packaging time

* None

## Extra content

Extra content packaged inside the provisioned server

* None

# Openshift build and deployment

Technologies required to build and deploy this example

* docker

* Helm chart for EAP 8.1 `jboss-eap/eap81`.

# Pre-requisites

* You have docker setup.

* You have a `Registry Service Account`. You can [create one](https://access.redhat.com/terms-based-registry/) if not.

* You have configured docker to access the EAP 8.1 images. For detailed instructions check the URL: `https://access.redhat.com/terms-based-registry/#/token/<your user id>/docker-login`.

* You are logged into an OpenShift cluster and have `oc` command in your path

* You have installed Helm. Please refer to [Installing Helm page](https://helm.sh/docs/intro/install/) to install Helm in your environment

* You have installed the repository for the Helm charts for EAP 8.1

 ```
helm repo add jboss-eap https://jbossas.github.io/eap-charts/
```

* You have built EAP 8.1 and artifacts are present in your local maven cache


# Example steps

## Build the image

1. Build the application  and server

```
mvn clean package [-Dversion.eap=<your SNAPSHOT version>]
```

2. Build the docker image

```
docker build --squash -t eap81-myapp:latest .
```

## Deploy the image on Openshift

1. Push the image to the Openshift Sandbox

Make sure to set the `OPENSHIFT_IMAGE_REGISTRY` env variable with the actual route to the registry. 
When logging to the registry, the route to the registry will be printed on the console.

```
export IMAGE=eap81-myapp:latest
export OPENSHIFT_NS=$(oc project -q)
oc registry login
# Copy the route in the env variable OPENSHIFT_IMAGE_REGISTRY
OPENSHIFT_IMAGE_REGISTRY=$(oc registry info)
docker login -u openshift -p $(oc whoami -t)  $OPENSHIFT_IMAGE_REGISTRY
docker tag  $IMAGE $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$IMAGE
docker push  $OPENSHIFT_IMAGE_REGISTRY/$OPENSHIFT_NS/$IMAGE
```

2. Enable the pushed image stream resolution

```
oc set image-lookup eap81-myapp
```

3. Deploy the example application using EAP 8.1 Helm charts

```
helm install eap81-myapp -f helm.yaml jboss-eap/eap81
```

4. Access the endpoint

```
curl https://$(oc get route eap81-myapp --template='{{ .spec.host }}')/
```
