Feature: install locally

  While testing your application using cucumber/aruba it can be
  useful to install your build output locally and add your local
  bin folder to aruba's path to ensure that when you invoke your
  application aruba's shell will find your local build output
  first before any copy that might be installed globaly on the
  host machine.

  Scenario: install build output in aruba's test folder and make it discoverable in the PATH
    Given I have installed my app into "local_bin" within the current directory
    And I look for executables in "local_bin" within the current directory
    When I successfully run `do-something`
    Then the output should contain:
      """
      doing something amazing
      """