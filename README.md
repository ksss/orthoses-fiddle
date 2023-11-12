# Orthoses::Fiddle

[orthoses](https://github.com/ksss/orthoses) extention for fiddle

orthoses-fiddle generate RBS from `Fiddle::Importer#extern`.

```rb
module M
  extend ::Fiddle::Importer
  dlload libc_so
  extern "size_t strlen(const char*)"
end
```

```rbs
module M
  # extern "size_t strlen(const char*)"
  def self.strlen: (untyped) -> Integer
end
```

## Installation

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_PRIOR_TO_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

    $ bundle add UPDATE_WITH_YOUR_GEM_NAME_PRIOR_TO_RELEASE_TO_RUBYGEMS_ORG

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install UPDATE_WITH_YOUR_GEM_NAME_PRIOR_TO_RELEASE_TO_RUBYGEMS_ORG

## Usage

```rb
Orthoses::Builder.new do
  use Orthoses::CreateFileByName,
      depth: 1,
      to: 'out'
      rmtree: true
  use Orthoses::Fiddle
  run -> {
    module M
      extend ::Fiddle::Importer
      dlload libc_so
      extern "int strcmp(char*, char*)"
    end
  }
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ksss/orthoses-fiddle. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ksss/orthoses-fiddle/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Orthoses::Fiddle project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ksss/orthoses-fiddle/blob/main/CODE_OF_CONDUCT.md).
