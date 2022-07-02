Feature: install locally

  While testing your application using cucumber/aruba it can be
  useful to install your built CLI tool into aruba's temporary
  Test Directory and add it to aruba's path to ensure that when
  your feature steps invoke your application aruba's shell will
  find your local binary first before any copy that might be
  installed globaly on the host machine.

  Scenario: install build output in aruba's Test Directory and make it discoverable in the local PATH
    Given I have installed my app into "local_bin" within the current directory
    And I look for executables in "local_bin" within the current directory
    When I successfully run `do-something`
    Then the output should contain:
      """
      doing something amazing
      """