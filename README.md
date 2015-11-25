# Specstat Reporter for RSpec

[![Build Status](https://travis-ci.org/jayzes/specstat-rspec.svg?branch=master)](https://travis-ci.org/jayzes/specstat-rspec)

This is a reporter gem for Specstat - it hooks into your  RSpec suite to provide
detailed information to the Specstat service on your specs, their runtime, and
their success/failure rates.

## Installation

Add this line to your application's Gemfile, in the test group:

```ruby
gem 'specstat-reporter', group: :test
```

And then execute:

    $ bundle

## Usage

The reporter will automatically wire itself into your RSpec suite on load. You
do need to specify your API token for reporting data back to the service - that
  can be done with an environment variable (`SPECSTAT_API_KEY`) or explicitly in
  your `spec_helper.rb` with a line like this:

```ruby
Specstat::Reporter.api_token = 'YOUR_API_TOKEN'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jayzes/specstat-reporter-rspec. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

