# frozen_string_literal: true

module Orthoses
  module Fiddle
    class Importer
      def initialize(loader)
        @loader = loader
      end

      def call
        extern = CallTracer::Lazy.new
        store = extern.trace('Fiddle::Importer#extern') do
          @loader.call
        end

        self.class.include ::Fiddle::Types

        extern.captures.each do |capture|
          base_name = Utils.module_name(capture.method.receiver) or next
          signature = capture.argument[:signature]
          name, return_type, argument_types = ::Fiddle::Importer.parse_signature(signature)
          args = argument_types.each_with_index.map do |fiddle_type, i|
            fiddle_to_rbs(fiddle_type, before: argument_types[i - 1])
          end
          store[base_name] << "# extern \"#{capture.argument[:signature]}\""
          store[base_name] << "def self.#{name}: (#{args.join(', ')}) -> #{fiddle_to_rbs(return_type)}"
        end

        store
      end

      def fiddle_to_rbs(fiddle_type, before: nil)
        case fiddle_type
        when VOID
          'void'
        when VOIDP
          'untyped'
        when CHAR, UCHAR, SHORT, USHORT, INT, UINT, LONG, ULONG, LONG_LONG, ULONG_LONG,
             INT8_T, UINT8_T, INT16_T, UINT16_T, INT32_T, UINT32_T, INT64_T, UINT64_T,
             SIZE_T, SSIZE_T, PTRDIFF_T, INTPTR_T, UINTPTR_T
          'Integer'
        when FLOAT, DOUBLE
          'Float'
        when CONST_STRING
          'String'
        when VARIADIC
          unless before
            return Orthoses.logger.error("Found unexpected signature")
          end
          "*#{fiddle_to_rbs(before)}"
        else
          if defined?(BOOL) && fiddle_type == BOOL
            'bool'
          else
            raise "`#{fiddle_type}` is unsupported yat"
          end
        end
      end
    end
  end
end
