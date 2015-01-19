require 'thor'
require 'chefdore'
require 'json'

module Chefdore
  class Cli < Thor
    namespace "chefdore"
    map %w(v V -v -V ver --version) => :version

    desc "convert", "Convert Chef role to a Chef cookbook. Expects the json formatted Chef Role to be piped to this command."
    def convert
      ARGV.replace []
      stdin = ARGF.read

      begin
        Chefdore::Magic.convert(stdin)
      rescue JSON::ParserError => e
        puts e.message
        exit 1
      end

    end

    desc "version", "Display version information"
    def version
      say Chefdore::VERSION
    end
  end
end
