# Envp

A Ruby gem for working with environment variables much like OptionParser does with command-line arguments.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add envp

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install envp

## Usage

`Envp` allows you to write expectations for environment variables for your program.

### Simple example

Define a program in a new file `app.rb`:

``` ruby
reqiure 'envp'

pp Envp.parse do |e|
  e.required("FOO")
end
```

Run the program without any special environment variables:

``` sh
$ ruby app.rb
app.rb:47:in `handle_errors': FOO: missing required value (Envp::Failure)
  from app.rb:26:in `parse'
  from -e:1:in `<main>'
```

Rather then let the program continue with missing required values, an exception is raised immediately.

Run the program with the required environment variables:

``` sh
$ FOO=bar ruby app.rb
{"FOO"=>"bar"}
```

The specified environment variables are parsed into a Ruby hash for use in your program.

### Coercions

Environment variables can be coerced from string values into richer types. For example, to parse a value into an integer:

``` ruby
reqiure 'envp'

pp Envp.parse do |e|
  e.required("FOO", Integer)
end
```

Will result in:

``` sh
$ FOO=123 ruby app.rb
{"FOO"=>123}
```

Along with various predefined coercions, you can define your own coercions:

``` ruby
reqiure 'envp'

pp Envp.parse do |e|
  e.accept(User) do |id|
    User.find(id)
  end
  e.required("USER_ID", User)
end
```

### Full example

The following example demonstrates all features:

``` ruby
Envp.parse(constants: true, symbolize: true, normalize: true) do |e|
  e.accept(User) do |id|
    User.find(id)
  end
  e.required("USER_ID", User)
  e.required("API_KEY", allow_blank: false) do |value|
    DEFAULT_LOGGER.debug("using API_KEY #{value}")
  end
  e.optional("DEBUG", :bool, default: false)
end
# => {:user_id=>#<User...>, :api_key=>"abc123", :debug=>false}
Envp::DEBUG # => false
Envp::API_KEY # => "abc123"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/avdgaag/envp. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/avdgaag/envp/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Envp project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/avdgaag/envp/blob/main/CODE_OF_CONDUCT.md).
