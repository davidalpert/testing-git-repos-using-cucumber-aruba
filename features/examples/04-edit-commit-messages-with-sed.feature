Feature: edit commit messages with sed

  By default git uses VI as an editor which creates automation challenges
  in a feature spec.  One alternative is to use the SED editor, script
  the edits you intend to make to a commit message, and temporarily set


  Background:
    Given git does not search outside the current directory

  Scenario: can read the last log message
    Given a simple git repo at "example" with the following empty commits:
      | Name     | Email              | Commit_Message       |
      | Bob Doe  | bob@findmypast.com | Bob's empty commit   |
      | Jane Doe | jane@example.com   | initial empty commit |
    When I cd to "example"
    Then the most recent commit log should contain:
      """
      Bob's empty commit
      """

  Scenario: can use sed as a git editor
    Given a simple git repo at "example" with the following empty commits:
      | Name     | Email              | Commit_Message       |
      | Bob Doe  | bob@findmypast.com | Bob's empty commit   |
      | Jane Doe | jane@example.com   | initial empty commit |
    When I cd to "example"
    And I prepare to edit the commit message with sed:
      """
      s/empty commit/amended commit/
      """
    And I successfully run `git commit --allow-empty --amend`
    Then the most recent commit log should contain:
      """
      Bob's amended commit
      """