@jboss-eap-8/eap8-openjdk17-builder-openshift-rhel8
Feature: EAP ubi8 specific tests

  Scenario: Check if image version and release is printed on boot
    Given s2i build https://github.com/jboss-container-images/jboss-eap-8-openshift-image from test/test-app with env and True using eap8-dev
    | variable                 | value           |
    ### PLACEHOLDER FOR CLOUD CUSTOM TESTING ###
    Then container log should contain Running jboss-eap-8/
    Then exactly 2 times container log should contain WFLYSRV0025:

  Scenario: Check for adjusted heap sizes
    When container integ- is started with args
      | arg       | value                                                    |
      | env_json  | {"JAVA_MAX_MEM_RATIO": 25, "JAVA_INITIAL_MEM_RATIO": 50} |
    Then container log should match regex ^ *JAVA_OPTS: *.* -XX:InitialRAMPercentage=50.0\s
    And container log should match regex ^ *JAVA_OPTS: *.* -XX:MaxRAMPercentage=25.0\s

  # CLOUD-459 (override default heap size)
  Scenario: CLOUD-459 Check for adjusted default heap size
    When container integ- is started with args
      | arg       | value                         |
      | env_json  | {"INITIAL_HEAP_PERCENT": 0.5} |
    Then container log should match regex ^ *JAVA_OPTS: *.* -XX:InitialRAMPercentage=50.0\s

  Scenario: Check if image version and release is printed on boot
    Given s2i build https://github.com/jboss-container-images/jboss-eap-8-openshift-image from test/vanilla-eap/test-app with env and True using eap8-dev
    | variable                             | value         |
    ### PLACEHOLDER FOR CLOUD CUSTOM TESTING ###
    Then container log should contain Running jboss-eap-8/

  Scenario: Check for adjusted heap sizes
    When container integ- is started with args
      | arg       | value                                                    |
      | env_json  | {"JAVA_MAX_MEM_RATIO": 25, "JAVA_INITIAL_MEM_RATIO": 50} |
    Then container log should match regex ^ *JAVA_OPTS: *.* -XX:InitialRAMPercentage=50.0\s
    And container log should match regex ^ *JAVA_OPTS: *.* -XX:MaxRAMPercentage=25.0\s

  # CLOUD-459 (override default heap size)
  Scenario: CLOUD-459 Check for adjusted default heap size
    When container integ- is started with args
      | arg       | value                         |
      | env_json  | {"INITIAL_HEAP_PERCENT": 0.5} |
    Then container log should match regex ^ *JAVA_OPTS: *.* -XX:InitialRAMPercentage=50.0\s