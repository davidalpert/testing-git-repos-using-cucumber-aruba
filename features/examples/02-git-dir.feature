Feature: resolving GIT_DIR relative to a nested repo

  All aruba features are executed inside aruba's `working_directory` which
  I am calling our Test Directory; by default this is
  `PROJECT_DIRECTORY/tmp/aruba/`

  According to the git documentation for ["Repository Locations"](https://git-scm.com/book/en/v2/Git-Internals-Environment-Variables#_repository_locations)

      Git uses several environment variables to determine how it interfaces with the current repository.

      GIT_DIR is the location of the .git folder. If this isn’t specified, Git walks up the directory tree until it gets to ~ or /, looking for a .git directory at every step.

      GIT_CEILING_DIRECTORIES controls the behavior of searching for a .git directory. If you access directories that are slow to load (such as those on a tape drive, or across a slow network connection), you may want to have Git stop trying earlier than it might otherwise, especially if Git is invoked when building your shell prompt.

  Using GIT_CEILING_DIRECTORIES we can teach aruba to ignore the parent Project Directory's GIT_DIR

  # @announce-paths
  Scenario: GIT_DIR from the test working folder resolves to REPOSITORY_ROOT
    Given git does not search outside the current directory
    Then the current working directory should match "tmp/aruba$"
    And git should not detect a repository

  # @announce-stdout
  Scenario: GIT_DIR from inside our example repo folder resolves to the example repo
    Given git does not search outside the current directory
    And a simple git repo at "example"
    When I cd to "example"
    Then the current working directory should match "tmp/aruba/example$"
    And GIT_DIR should match "tmp/aruba/example$"
