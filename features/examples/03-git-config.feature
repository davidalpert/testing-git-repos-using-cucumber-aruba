Feature: git configuration

  Our Project Directory's '.git/config' file will have a remote reference to
  the project's origin ("remote.origin.url") but our Example Directory, created
  locally by the 'Given a simple git repo at "path' step, will not

  Scenario: git does not detect a repostory when run from the Test Directory
    Given git does not search outside the current directory
    Then git should not detect a repository

  Scenario: merged configuration from the nested example repo does not include the parent Project Directory's git configuration
    Given git does not search outside the current directory
    And a simple git repo at "example"
    When I cd to "example"
    Then git configuration should not contain "remote.origin.url"

  Scenario: aruba takes over $HOME
    Given git does not search outside the current directory
    And I set the global user config to "Mal Reynolds" "mal@serenity.com"
    Then the full path of "~/.gitconfig" should match "tmp/aruba/.gitconfig$"
    And the file "~/.gitconfig" should contain:
      """
      [user]
      	name = Mal Reynolds
      	email = mal@serenity.com
      """
    And the project directory's git config file should not contain "Mal Reynolds"

# these scenarios were an early attempt to work around the nested repo
# problem before I discovered GIT_CEILING_DIRECTORIES
# @with-no-project-git-user
# Scenario: with no project git user git reads local and global from test ~/.gitconfig
#   Given the repository git config file has no user section
#   When I set the global user config to "Mal Reynolds" "mal@serenity.com"
#   Then stdout from `git config --global user.name` should contain "Mal Reynolds"
#   And stdout from `git config user.name` should contain "Mal Reynolds"

# @with-no-project-git-user
# Scenario: with a project git user git reads global from test ~/.gitconfig but local from project .git/config
#   Given I set the repository user config to "Zoe Washburn" "zoe@serenity.com"
#   Then the repository git config file should contain "Zoe Washburn"
#   Given I set the global user config to "Mal Reynolds" "mal@serenity.com"
#   Then stdout from `git config --global user.name` should contain "Mal Reynolds"
#   Then stdout from `git config user.name` should not contain "Mal Reynolds"
#   Then stdout from `git config user.name` should contain "Zoe Washburn"