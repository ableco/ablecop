# AbleCop

AbleCop is a collection of best practices for writing code at Able. These
practices are reinforced on the project level through comments on commits
and pull requests that find violations.

## Gem installation

Add this line to your application's Gemfile to both the `:development` and `:test` groups:

```ruby
group :development, :test do
  gem "ablecop", git: "https://github.com/ableco/ablecop.git", tag: "v0.7.0"
end
```

Run `bundle install` to install all the necessary gems.

You can change the `tag` in the Gemfile to point to an [earlier release](https://github.com/ableco/ablecop/releases) if you want to install an older version of AbleCop.

## Configuration file setup

AbleCop comes with a generator that will copy the default configuration
files for each of the gems used for testing. Run the following command:


```
bundle exec rails g ablecop:install
```

This will create the following configuration files in your project and add them to your project's `.gitignore`:

* `.rubocop.yml`
* `.fasterer.yml`
* `.scss-lint.yml`
* `config/rails_best_practices.yml`

## Overriding default configuration files

You can override the default configuration files by placing specific
files in the `config/ablecop` directory of your project containing
additional configuration settings (in YAML format). You can add the
following override files:

* `config/ablecop/.rubocop.yml`
* `config/ablecop/.fasterer.yml`
* `config/ablecop/.scss-lint.yml`
* `config/ablecop/rails_best_practices.yml`

By default, the values in the override files will be merged to the
default configuration files in the root of your project. You can also
remove settings from the default configuration files by appending '--'
to an existing setting in the override file (see examples below).

### Override examples

Given a default configuration file:

```yaml
# Example default configuration for Rubocop.
# Location: .rubocop.yml

AllCops:
  Include:
    - 'bin/**/*'
    - 'db/schema.rb'
```

If you want to add a new value under `AllCops` -> `Include` and
remove the `db/schema.rb` value, set your override file to the
following:

```yaml
# Example override file for Rubocop.
# Location: config/ablecop/.rubocop.yml

AllCops:
  Include:
    - '--db/schema.rb'
    - 'db/seeds/**/*'
```

When running the generator, the override file will be merged into the
default configuration file:

```yaml
# Example default configuration for Rubocop.
# Location: .rubocop.yml

AllCops:
  Include:
    - 'bin/**/*'
    - 'db/seeds/**/*'
```

## CircleCI / GitHub Setup

To enable CircleCI to run AbleCop's checks and comment on commits with each
push, add the following configuration to your project's `circle.yml`:

```yml
test:
  pre:
    - bundle exec rails g ablecop:install
  post:
    - RAILS_ENV=development bundle exec rake ablecop:run_on_circleci
```

You also need to set up the `PRONTO_GITHUB_ACCESS_TOKEN` environment variable in CircleCI. This is a personal access token from GitHub that will allow AbleCop to post comments for warnings that occur in your commits, as well as update a pull request's status if it exists.

To set up the environment variable in CircleCI, you can either [include it in your circleci.yml configuration file](https://circleci.com/docs/configuration/#environment) or add it directly in CircleCI by going to your project in CircleCI and going to **Project Settings > Environment Variables**. It is strongly recommended that the environment variable is added in CircleCI directly.

If you do not have an access token from GitHub, you can create one by following [these instructions](https://help.github.com/articles/creating-an-access-token-for-command-line-use/).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ableco/ablecop.
