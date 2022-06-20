Feature: git configuration

  Background:
    Given I have installed my app into "local_bin" within the current directory
    And I look for executables in "local_bin" within the current directory
    And a simple git repo at "example"

  Scenario: merged configuration from the test folder shows remote origin
    And git configuration should contain "remote.origin.url"

  Scenario: merged configuration from the nested example repo does not
    When I cd to "example"
    Then git configuration should not contain "remote.origin.url"

  Scenario: aruba takes over $HOME
    Given I set the global user config to "Mal Reynolds" "mal@serenity.com"
    Then the full path of "~/.gitconfig" should match "tmp/aruba/.gitconfig$"
    And the file "~/.gitconfig" should contain:
      """
      [user]
      	name = Mal Reynolds
      	email = mal@serenity.com
      """
    And the repository git config file should not contain "Mal Reynolds"

  @with-no-project-git-user
  Scenario: with no project git user git reads local and global from test ~/.gitconfig
    Given the repository git config file has no user section
    When I set the global user config to "Mal Reynolds" "mal@serenity.com"
    Then stdout from `git config --global user.name` should contain "Mal Reynolds"
    And stdout from `git config user.name` should contain "Mal Reynolds"

  @with-no-project-git-user
  Scenario: with a project git user git reads global from test ~/.gitconfig but local from project .git/config
    Given I set the repository user config to "Zoe Washburn" "zoe@serenity.com"
    Then the repository git config file should contain "Zoe Washburn"
    Given I set the global user config to "Mal Reynolds" "mal@serenity.com"
    Then stdout from `git config --global user.name` should contain "Mal Reynolds"
    Then stdout from `git config user.name` should not contain "Mal Reynolds"
    Then stdout from `git config user.name` should contain "Zoe Washburn"
  # Scenario: aruba's "global" git config is overridden by local REPOSITORY_DIR's git settings
    # When I cd to "example"
    # And I set the local user config to "Jayne Cobb" "jayne@serenity.com"
    # Then the full path of "." should match "tmp/aruba/example$"
    # And the full path of ".git/config" should match "tmp/aruba/example/.git/config$"
    # And the file ".git/config" should contain:
    #   """
    #   [user]
    #   	name = Jayne Cobb
    #   	email = jayne@serenity.com
    #   """
    # And the repository git config file should not contain "Jayne Cobb"