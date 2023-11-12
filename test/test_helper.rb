require 'rgot/cli'
require 'orthoses/fiddle'

Orthoses.logger.level = :error
exit Rgot::Cli.new(["-v", *ARGV]).run
