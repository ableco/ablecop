# AbleCop Changelog

## Unreleased

- **AbleCop**: Set Gemfile to use Ruby 2.3.3 for development
- **AbleCop**: Update development dependency gems (Rake and RSpec) to their latest versions
- **Pronto**: Update to [0.8.2](https://github.com/mmozuras/pronto/blob/master/CHANGELOG.md#082), and all its associated runners to 0.8.x
- **RuboCop**: Update to [0.47.1](https://github.com/bbatsov/rubocop/blob/master/CHANGELOG.md#0471-2017-01-18)
- **RuboCop**: Update the default configuration file to support the latest RuboCop version
- **Brakeman**: Update to [3.5.0](https://github.com/presidentbeef/brakeman/blob/master/CHANGES)
- **scss-lint**: Update to [0.52.0](https://github.com/brigade/scss-lint/blob/master/CHANGELOG.md#0520)
- **rails_best_practices**: Update to [1.18.0](https://github.com/railsbp/rails_best_practices/blob/master/CHANGELOG.md#1180-2017-03-01)
- **AbleCop**: Disabled the [Pronto::RailsSchema](https://github.com/raimondasv/pronto-rails_schema) runner due to currently not having support for Pronto 0.8.x

## 0.3.5

- **Pronto**: Update to [0.7.1](https://github.com/mmozuras/pronto/blob/master/CHANGELOG.md#071), and all its associated runners to 0.7.x (#29)
- **RuboCop**: Update to [0.42.0](https://github.com/bbatsov/rubocop/blob/master/CHANGELOG.md#0420-2016-07-25) (#29)
- **Brakeman**: Update to [3.3.5](https://github.com/presidentbeef/brakeman/blob/master/CHANGES) (#29)
- **scss-lint**: Update to [0.49.0](https://github.com/brigade/scss-lint/blob/master/CHANGELOG.md#0490) (#29)
- **rails_best_practices**: Update to [1.17.0](https://github.com/railsbp/rails_best_practices/blob/master/CHANGELOG.md#1170-2016-07-14) (#29)
- **rails_best_practices**: Comment out [RemoveTrailingWhitespaceCheck](http://rails-bestpractices.com/posts/2010/12/02/remove-trailing-whitespace/) since RuboCop already does the same (#30)
- Use new `GithubPullRequestFormatter` formatter to update GitHub's pull request statuses and remove custom code written to do this (#29)
- Set minimum Ruby version for AbleCop to Ruby 2.2.0 (#29)


## 0.3.4

- **scss-lint**: Update the [DuplicateProperty](https://github.com/brigade/scss-lint/blob/master/lib/scss_lint/linter/README.md#duplicateproperty) rule to `ignore_consecutive: true`.
- **brakeman**: Upgraded to [3.3.2](http://brakemanscanner.org/blog/2016/06/10/brakeman-3-dot-3-2-released/).

## 0.3.3

- Ensure [pronto-brakeman](https://github.com/mmozuras/pronto-brakeman) is loaded last to deal with bug related to load order (#20)

## 0.3.2

- Set Rubocop's `TargetRubyVersion` to `2.2`. (#9)
- Add method to ensure that the project's `.gitignore` file includes only AbleCop's configuration files, as opposed to ignoring all files of the same name (which includes the project's override files). (#10)
- Comment out checks for unused methods in rails_best_practices due to a high number of false positives (#14)

## 0.3.1

- Bug fix: Use CircleCI's environment variables to set up the appropriate GitHub repo when running the `ablecop:run_on_circleci` Rake task.

## 0.3.0

- Set up [rails_best_practices](https://github.com/railsbp/rails_best_practices) and its [Pronto runner](https://github.com/mmozuras/pronto-rails_best_practices).
- Refactored Rails generator to easily be able to copy files to different destinations on a project.

## 0.2.1

- Bug fix: Use CircleCI's environment variables to set up the appropriate GitHub repo when running the `ablecop:run_on_circleci` Rake task.

## 0.2.0

- Refactored Rails generator so that we only add filenames to the project's `.gitignore` file only once (instead of once per file that needs to be added).
- Added the [octokit](https://github.com/octokit/octokit.rb) gem as a dependency.
- Added a post-install message with information on how to set up AbleCop locally and on CircleCI.
- Minor gemspec cleanup:
  - Do not include any executable scripts in the gem.
  - Added summary and description.
- Upgraded Rubocop (0.40.0) and Brakeman (3.3.0) gems to their latest versions and updated the default configuration files where necessary.

## 0.1.0 (Initial release)

- Set up [Rubocop](https://github.com/bbatsov/rubocop), [fasterer](https://github.com/DamirSvrtan/fasterer), [Brakeman](https://github.com/presidentbeef/brakeman) and [scss-lint](https://github.com/brigade/scss-lint) libraries.
- Set up [Pronto](https://github.com/mmozuras/pronto) and runners for [Rubocop](https://github.com/mmozuras/pronto-rubocop), [fasterer](https://github.com/mmozuras/pronto-fasterer), [Brakeman](https://github.com/mmozuras/pronto-brakeman), [Pronto::RailsSchema](https://github.com/raimondasv/pronto-rails_schema) and [scss-lint](https://github.com/mmozuras/pronto-scss).
- Added a Rails generator to copy default configuration files and include the files in the project's `.gitignore` file.
- Allow a project using the gem to override the default configuration files.
