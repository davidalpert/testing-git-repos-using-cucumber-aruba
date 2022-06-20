Feature: resolving GIT_DIR relative to a nested repo

  All aruba features are executed inside the aruba working
  directory. By default this is `REPOSITORY_ROOT/tmp/aruba/`.

  GIT_DIR is resolved relative to the repository root when
  working in `tmp/aruba/` unless you are inside a git repo
  under `tmp/aruba/<subfolder>/`

  Our checkout directory's ".git/config" will have a remote
  reference to origin ("remote.origin.url") but our example
  directory, created locally using the "simple git repo" step,
  will not.

  Background:
    Given I have installed my app into "local_bin" within the current directory
    And I look for executables in "local_bin" within the current directory
    And a simple git repo at "example"

  # @announce-stdout
  Scenario: GIT_DIR from the test working folder resolves to REPOSITORY_ROOT
    Then stdout from `pwd` should match "tmp/aruba$"
    And GIT_DIR should not contain "tmp/aruba"

  # @announce-stdout
  Scenario: GIT_DIR from inside our example repo folder resolves to the example repo
    When I cd to "example"
    Then stdout from `pwd` should match "tmp/aruba/example$"
    And GIT_DIR should match "tmp/aruba/example$"
