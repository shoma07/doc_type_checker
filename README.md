# DocTypeChecker

This is type checker for Ruby at runtime using [YARD](https://github.com/lsegal/yard).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'doc_type_checker'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install doc_type_checker

## Usage

### Configuration

```ruby
DocTypeChecker.configure do |config|
  config.enabled = true # or false, default is false
  config.yard_run_arguments = ['--hide-void-return']
  # Throw exception if type validation fails.
  config.strict = true # or false, default is false
  config.logger = Logger.new(STDOUT) # default is nil
end
```

## Features

- Support enumerate types `Array<String>, Hash<Symbol, String>`
- Support method types `#to_s`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/doc_type_checker.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
