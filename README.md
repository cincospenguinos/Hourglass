# Hourglass

A static code evaluation tool, designed to find dead method references. Eventually it will do more.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hourglass'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hourglass

## Usage

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can 
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cincospenguinos/hourglass. This project is
intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## TODO

- [x] Detect unused methods inside a single class
- [ ] Gather sets of files and indicate which are unused in a single class
- [ ] CLI for usage
- [ ] Configuration object
- [ ] Detect used methods via reflection

## NOTES

* Things I want:
    1. Something to gather all of the files
    2. CLI support
    3. Rails support--scopes, before/after actions, etc.
* So `RubyParser#parse` returns a symbolic expression, which can be interacted with--memoized, queried, defined
