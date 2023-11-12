# frozen_string_literal: true

require 'test_helper'

module ImporterTest
  LOADER = ->{
    require 'fiddle/import'

    module M
      libc_so = nil
      # https://github.com/ruby/ruby/blob/40391faeab608665da87a05c686c074f91a5a206/test/fiddle/helper.rb
      case RUBY_PLATFORM
      when /linux/
        libc_so, = Dir.glob(File.join('/lib', "libc.musl*.so*"))
        libc_so ||=
          case RUBY_PLATFORM
          when /alpha-linux/, /ia64-linux/
            "libc.so.6.1"
          else
            "libc.so.6"
          end
      when /darwin/
        libc_so = "/usr/lib/libSystem.B.dylib"
      end

      extend ::Fiddle::Importer
      dlload libc_so
      extern "size_t strlen(const char*)"
      extern "int rand(void)"
      extern "int scanf(const char *restrict format, ...)"
    end
  }
  def test_extern(t)
    store = Orthoses::Fiddle::Importer.new(
      Orthoses::Store.new(LOADER)
    ).call
    actual = store['ImporterTest::M'].to_rbs
    expect = <<~RBS
      module ImporterTest::M
        # extern "size_t strlen(const char*)"
        def self.strlen: (untyped) -> Integer

        # extern "int rand(void)"
        def self.rand: () -> Integer

        # extern "int scanf(const char *restrict format, ...)"
        def self.scanf: (untyped, *untyped) -> Integer
      end
    RBS
    unless expect == actual
      t.error("expect=\n```rbs\n#{expect}```\n, but got \n```rbs\n#{actual}```\n")
    end
  end
end
