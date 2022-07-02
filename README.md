[![License: GPL v3][license-shield]][license-url]

<!-- PROJECT LOGO -->
<br />
<!-- vale Google.Headings = NO -->
<h1 align="center">testing-git-repos-using-cucumber-aruba</h1>
<!-- vale Google.Headings = YES -->

<p align="center">
  An example repository demonstrating how to set up functional integration tests
  for git plugins using `cucumber/aruba` 
  <br />
  <!-- <a href="./README.md"><strong>README</strong></a>
  ·
  <a href="./CHANGELOG.md">CHANGELOG</a>
  .
  <a href="./CONTRIBUTING.md">CONTRIBUTING</a>
  <br /> -->
  <a href="https://github.com/davidalpert/testing-git-repos-using-cucumber-aruba/issues">Report Bug</a>
  ·
  <a href="https://github.com/davidalpert/testing-git-repos-using-cucumber-aruba/issues">Request Feature</a>
</p>

<details open="open">
  <summary><h2 style="display: inline-block">Table of contents</h2></summary>

- [About the project](#about-the-project)
  - [Built with](#built-with)
- [Concepts](#concepts)

</details>

<!-- ABOUT THE PROJECT -->
## About the project

This repository is a working demonstration of the concepts I recently blogged about.

### Built with

- [git version 2.35.1](https://git-scm.com/) (not included)
- [ruby 3.0.2](https://www.ruby-lang.org/en/news/2021/07/07/ruby-3-0-2-released/)
- [cucumber 7.1.0](https://github.com/cucumber/cucumber-ruby)
- [aruba 2.0.0](https://github.com/cucumber/aruba)

## Concepts

This repository includes cucumber/aruba feature files and step definitions which present a pattern for testing git operations inside the aruba test folder.

When you use aruba to git commands several things can get a bit tricky, primarily because git assumes that it can walk it's parent directories to find the closest `.git/` folder.

Aruba by default runs test scenarios inside a `./tmp/aruba/` folder relative to the current working directory.

The creation of one `.git/` folder inside another means that you need to be mindful of how setup is done or else `.git` commands run by your features may inadvertently affect the parent project's configuration and commit history:
```
.                                (Project Directory)
├── .git                         (Project GIT_DIR)
│   └── ...
├── .gitignore
├── .ruby-version
├── Gemfile
├── Gemfile.lock
├── LICENSE
├── Makefile
├── README.md
├── bin
│   └── do-something
├── features
│   └── ...
└── tmp
    └── aruba                    (Test Directory)
        ├── .gitconfig
        └── example              (Example Directory)
            ├── .git             (Example GIT_DIR)
            │   └── ...
            └── ...
```

For the purpose of this repository consider the following three folders:

| term                     | path                   | meaning                                                                                                                                                  |
| ------------------------ | ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| _Project&nbsp;Directory_ | `.`                    | the top-level working directory of this repository; the one that is created when you clone this repository                                               |
| _Test&nbsp;Directory_    | `./tmp/aruba/`         | the top-level working directory for the test run, a temporary test folder created by aruba; all feature steps are evaluated relative to this root folder |
| _Example&nbsp;Directory_ | `./tmp/aruba/example/` | the top-level working directory of the example folder my-project/tmp/tests/example/                                                                      |

This gives us two `GIT_DIR`s, one inside the other:

| term                   | path                        | meaning                                   |
| ---------------------- | --------------------------- | ----------------------------------------- |
| _Project&nbsp;GIT_DIR_ | `.git/`                     | the `GIT_DIR` for the `Project Directory` |
| _Example&nbsp;GIT_DIR_ | `./tmp/aruba/example/.git/` | the `GIT_DIR` for the `Example Directory` |



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[forks-shield]: https://img.shields.io/github/forks/davidalpert/testing-git-repos-using-cucumber-arubas
[forks-url]: https://github.com/davidalpert/testing-git-repos-using-cucumber-aruba/network/members
[issues-shield]: https://img.shields.io/github/issues/davidalpert/testing-git-repos-using-cucumber-arubas
[issues-url]: https://github.com/davidalpert/testing-git-repos-using-cucumber-aruba/issues
[license-shield]: https://img.shields.io/badge/License-GPLv3-blue.svg
[license-url]: https://www.gnu.org/licenses/gpl-3.0