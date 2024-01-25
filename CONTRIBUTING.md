# Contributing Guide

## Code of Conduct

We welcome pull requests from everyone. By participating in this project, you
agree to abide by the thoughtbot [code of conduct].

We expect everyone to follow the code of conduct anywhere in thoughtbot's
project codebases, issue trackers, chat-rooms, and mailing lists.

[code of conduct]: https://thoughtbot.com/open-source-code-of-conduct

## Getting Started

`administrate-field-nested_has_many` is a field plugin for [Administrate][],
that allows for nested `has_many` forms.

To maintain compatibility with different dependency versions, we use
[Appraisal][].

[Administrate]: https://github.com/thoughtbot/administrate
[Appraisal]: https://github.com/thoughtbot/appraisal

### Opening a PR

1. Fork the repo,
2. Run `./bin/setup` to install the base dependencies and setup a local
   database,
3. Run the test suite: `bundle exec rspec && bundle exec appraisal rspec`,
4. Make your changes,
5. Push your fork and open a pull request.

A good PR will solve the smallest problem it possibly can, have good test
coverage and (where necessary) have internationalisation support.

## Security

See the [security policy](./SECURITY.md).
