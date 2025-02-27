@jboss-eap-8
@jboss-eap-8-tech-preview
Feature: EAP Legacy s2i tests

  Scenario: Test provisioning.xml file
    Given s2i build https://github.com/jboss-container-images/jboss-eap-8-openshift-image from test/vanilla-eap/test-app-local-provisioning with env and True using eap81-beta-dev
      | variable                             | value         |
      | GALLEON_PROVISION_CHANNELS|org.jboss.eap.channels:eap-8.1 |
      | GALLEON_USE_LOCAL_FILE             | true  |
    Then container log should contain WFLYSRV0025
    And check that page is served
      | property | value |
      | path     | /     |
      | port     | 8080  |

Scenario: Test preconfigure.sh
    Given s2i build https://github.com/jboss-container-images/jboss-eap-modules from tests/examples/test-app-advanced-extensions with env and True using master
      | variable                             | value         |
      | TEST_EXTENSION_PRE_ADD_PROPERTY      | foo           |
      | GALLEON_PROVISION_CHANNELS|org.jboss.eap.channels:eap-8.1 |
      | GALLEON_PROVISION_LAYERS | cloud-server |
      | GALLEON_PROVISION_FEATURE_PACKS | org.jboss.eap:wildfly-ee-galleon-pack,org.jboss.eap.cloud:eap-cloud-galleon-pack |
   Then exactly 2 times container log should contain WFLYSRV0025:
    And container log should contain WFLYSRV0010: Deployed "ROOT.war"
    And check that page is served
      | property | value |
      | path     | /     |
      | port     | 8080  |
    Then XML file /opt/server/standalone/configuration/standalone.xml should contain value foo on XPath //*[local-name()='property' and @name="foo"]/@value
    Then XML file /opt/eap/standalone/configuration/standalone.xml should contain value foo on XPath //*[local-name()='property' and @name="foo"]/@value

 Scenario: Test invalid layer
    Given failing s2i build http://github.com/openshift/openshift-jee-sample from . using master
      | variable                             | value         |
      | GALLEON_PROVISION_CHANNELS|org.jboss.eap.channels:eap-8.1 |
      | GALLEON_PROVISION_LAYERS             | foo |
      | GALLEON_PROVISION_FEATURE_PACKS | org.jboss.eap:wildfly-ee-galleon-pack,org.jboss.eap.cloud:eap-cloud-galleon-pack |

  Scenario: Test default cloud config
    Given s2i build https://github.com/openshift/openshift-jee-sample from . with env and True using master
      | variable                             | value         |
      | GALLEON_PROVISION_CHANNELS|org.jboss.eap.channels:eap-8.1 |
      | GALLEON_PROVISION_FEATURE_PACKS | org.jboss.eap:wildfly-ee-galleon-pack,org.jboss.eap.cloud:eap-cloud-galleon-pack|
      | GALLEON_PROVISION_LAYERS | cloud-default-config |
    Then exactly 2 times container log should contain WFLYSRV0025
    And container log should contain WFLYSRV0010: Deployed "ROOT.war"
    And check that page is served
      | property | value |
      | path     | /     |
      | port     | 8080  |

  Scenario: Test cloud-server, exclude jaxrs
    Given s2i build https://github.com/openshift/openshift-jee-sample from . with env and True using master
      | variable                             | value         |
      | GALLEON_PROVISION_CHANNELS|org.jboss.eap.channels:eap-8.1 |
      | GALLEON_PROVISION_FEATURE_PACKS | org.jboss.eap:wildfly-ee-galleon-pack,org.jboss.eap.cloud:eap-cloud-galleon-pack |
      | GALLEON_PROVISION_LAYERS             | cloud-server,-jaxrs  |
    Then exactly 2 times container log should contain WFLYSRV0025:
    And check that page is served
      | property | value |
      | path     | /     |
      | port     | 8080  |
    Then XML file /opt/server/.galleon/provisioning.xml should contain value cloud-server on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='include']/@name
    Then XML file /opt/server/.galleon/provisioning.xml should contain value jaxrs on XPath //*[local-name()='installation']/*[local-name()='config']/*[local-name()='layers']/*[local-name()='exclude']/@name

  Scenario: Test preview FP and preview cloud FP with legacy app.
    Given s2i build https://github.com/openshift/openshift-jee-sample from . with env and True using master
      | variable                             | value         |
      | GALLEON_PROVISION_CHANNELS|org.jboss.eap.channels:eap-8.1 |
      | GALLEON_PROVISION_LAYERS | cloud-server |
      | GALLEON_PROVISION_FEATURE_PACKS | org.jboss.eap:wildfly-ee-galleon-pack,org.jboss.eap.cloud:eap-cloud-galleon-pack|
    Then exactly 2 times container log should contain WFLYSRV0025:
    And container log should contain WFLYSRV0010: Deployed "ROOT.war"
    And check that page is served
      | property | value |
      | path     | /     |
      | port     | 8080  |

Scenario: Test external driver created during s2i.
    Given s2i build https://github.com/wildfly/wildfly-s2i from test/test-app-custom with env and true using legacy-s2i-images
      | variable                     | value                                                       |
      | ENV_FILES                    | /opt/server/standalone/configuration/datasources.env |
      | GALLEON_PROVISION_CHANNELS|org.jboss.eap.channels:eap-8.1 |
      | GALLEON_PROVISION_LAYERS             | cloud-server  |
      | GALLEON_PROVISION_FEATURE_PACKS | org.jboss.eap:wildfly-ee-galleon-pack,org.jboss.eap.cloud:eap-cloud-galleon-pack |
    Then exactly 2 times container log should contain WFLYSRV0025:
    And check that page is served
      | property | value |
      | path     | /     |
      | port     | 8080  |
    Then XML file /opt/server/standalone/configuration/standalone.xml should contain value test-TEST on XPath //*[local-name()='datasource']/@pool-name
    Then XML file /opt/server/standalone/configuration/standalone.xml should contain value testpostgres on XPath //*[local-name()='driver']/@name

  Scenario: Test external driver created during s2i.
    Given s2i build https://github.com/wildfly/wildfly-s2i from test/test-app-custom with env and true using legacy-s2i-images
      | variable                     | value                                                       |
      | ENV_FILES                    | /opt/server/standalone/configuration/datasources.env |
      | DISABLE_BOOT_SCRIPT_INVOKER  | true |
      | GALLEON_PROVISION_CHANNELS|org.jboss.eap.channels:eap-8.1 |
      | GALLEON_PROVISION_LAYERS             | cloud-server  |
      | GALLEON_PROVISION_FEATURE_PACKS | org.jboss.eap:wildfly-ee-galleon-pack,org.jboss.eap.cloud:eap-cloud-galleon-pack |
    Then container log should contain Configuring the server using embedded server
    Then container log should contain WFLYSRV0025
    And check that page is served
      | property | value |
      | path     | /     |
      | port     | 8080  |
    Then XML file /opt/server/standalone/configuration/standalone.xml should contain value test-TEST on XPath //*[local-name()='datasource']/@pool-name
    Then XML file /opt/server/standalone/configuration/standalone.xml should contain value testpostgres on XPath //*[local-name()='driver']/@name

  Scenario: Test legacy binary build
    Given s2i build https://github.com/wildfly/wildfly-s2i from test/test-app-binary with env and True using legacy-s2i-images
      | variable                             | value         |
      | GALLEON_PROVISION_CHANNELS|org.jboss.eap.channels:eap-8.1 |
      | GALLEON_PROVISION_LAYERS             | cloud-server  |
      | GALLEON_PROVISION_FEATURE_PACKS | org.jboss.eap:wildfly-ee-galleon-pack,org.jboss.eap.cloud:eap-cloud-galleon-pack |
    Then container log should contain WFLYSRV0025
    And container log should contain WFLYSRV0010: Deployed "app.war"
    And check that page is served
      | property | value |
      | path     | /app     |
      | port     | 8080  |

 Scenario: Multiple deployments legacy
   Given s2i build https://github.com/jboss-container-images/jboss-eap-8-openshift-image from test/test-app-multi-deployments-legacy with env and True using eap81-beta-dev
   | variable                 | value           |
   | MAVEN_S2I_ARTIFACT_DIRS | app1/target,app2/target |
   | GALLEON_PROVISION_CHANNELS|org.jboss.eap.channels:eap-8.1 |
   | GALLEON_PROVISION_LAYERS             | cloud-server  |
   | GALLEON_PROVISION_FEATURE_PACKS | org.jboss.eap:wildfly-ee-galleon-pack,org.jboss.eap.cloud:eap-cloud-galleon-pack |
   ### PLACEHOLDER FOR CLOUD CUSTOM TESTING ###
   Then container log should contain WFLYSRV0010: Deployed "App1.war"
   Then container log should contain WFLYSRV0010: Deployed "App2.war"
   Then container log should contain WFLYSRV0025