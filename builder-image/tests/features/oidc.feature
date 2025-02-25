@jboss-eap-8
@jboss-eap-8-tech-preview
Feature: OIDC tests

   Scenario: Check oidc subsystem configuration.
     Given XML namespaces
       | prefix | url                          |
       | ns     | urn:wildfly:elytron-oidc-client:2.0 |
     Given s2i build https://github.com/jboss-container-images/jboss-eap-8-openshift-image from test/test-app-elytron-oidc-client with env and True using eap8-dev
       | variable               | value                                            |
       | OIDC_PROVIDER_NAME | keycloak |
       | OIDC_PROVIDER_URL           | http://localhost:8080/auth/realms/demo    |
       | OIDC_SECURE_DEPLOYMENT_ENABLE_CORS        | true                          |
       | OIDC_SECURE_DEPLOYMENT_BEARER_ONLY        | true                          |
       ### PLACEHOLDER FOR CLOUD CUSTOM TESTING ###
    Then container log should contain WFLYSRV0010: Deployed "oidc-webapp.war"
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value keycloak on XPath //ns:provider/@name
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value oidc-webapp.war on XPath //*[local-name()='secure-deployment']/@name
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value true on XPath //*[local-name()='provider']/*[local-name()='enable-cors']
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value true on XPath //*[local-name()='secure-deployment'][@name="oidc-webapp.war"]/*[local-name()='bearer-only']
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value true on XPath //*[local-name()='secure-deployment'][@name="oidc-webapp.war"]/*[local-name()='enable-basic-auth'] 
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value http://localhost:8080/auth/realms/demo on XPath //*[local-name()='provider']/*[local-name()='provider-url']

  Scenario: Provision oidc subsystem configuration, legacy.
    Given s2i build https://github.com/jboss-container-images/jboss-eap-8-openshift-image from test/test-app-elytron-oidc-client-legacy with env and True using eap8-dev
       | variable               | value                                            |
       | GALLEON_PROVISION_CHANNELS|org.jboss.eap.channels:eap-8.1 |
       | GALLEON_PROVISION_LAYERS | cloud-server,elytron-oidc-client |
       | GALLEON_PROVISION_FEATURE_PACKS|org.jboss.eap:wildfly-ee-galleon-pack,org.jboss.eap.cloud:eap-cloud-galleon-pack |

  Scenario: Check oidc subsystem configuration, legacy.
     Given XML namespaces
       | prefix | url                          |
       | ns     | urn:wildfly:elytron-oidc-client:2.0 |
     When container integ- is started with env
       | variable               | value                                            |
       | OIDC_PROVIDER_NAME | keycloak |
       | OIDC_PROVIDER_URL           | http://localhost:8080/auth/realms/demo    |
       | OIDC_SECURE_DEPLOYMENT_ENABLE_CORS        | true                          |
       | OIDC_SECURE_DEPLOYMENT_BEARER_ONLY        | true                          |
    Then container log should contain WFLYSRV0010: Deployed "oidc-webapp-legacy.war"
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value keycloak on XPath //ns:provider/@name
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value oidc-webapp-legacy.war on XPath //*[local-name()='secure-deployment']/@name
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value true on XPath //*[local-name()='provider']/*[local-name()='enable-cors']
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value true on XPath //*[local-name()='secure-deployment'][@name="oidc-webapp-legacy.war"]/*[local-name()='bearer-only']
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value true on XPath //*[local-name()='secure-deployment'][@name="oidc-webapp-legacy.war"]/*[local-name()='enable-basic-auth'] 
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value http://localhost:8080/auth/realms/demo on XPath //*[local-name()='provider']/*[local-name()='provider-url']

  Scenario: Check oidc subsystem configuration, legacy with ENV_FILES
     Given XML namespaces
       | prefix | url                          |
       | ns     | urn:wildfly:elytron-oidc-client:2.0 |
    When container integ- is started with command bash
       | variable                 | value           |
       | ENV_FILES | /tmp/oidc.env |
    Then copy features/image/scripts/oidc.env to /tmp in container
    And run sh -c '/opt/jboss/container/wildfly/run/run  > /tmp/boot.log 2>&1' in container and detach
    And file /tmp/boot.log should contain WFLYSRV0025
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value keycloak on XPath //ns:provider/@name
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value oidc-webapp-legacy.war on XPath //*[local-name()='secure-deployment']/@name
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value true on XPath //*[local-name()='provider']/*[local-name()='enable-cors']
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value true on XPath //*[local-name()='secure-deployment'][@name="oidc-webapp-legacy.war"]/*[local-name()='bearer-only']
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value true on XPath //*[local-name()='secure-deployment'][@name="oidc-webapp-legacy.war"]/*[local-name()='enable-basic-auth'] 
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value http://localhost:8080/auth/realms/demo on XPath //*[local-name()='provider']/*[local-name()='provider-url']