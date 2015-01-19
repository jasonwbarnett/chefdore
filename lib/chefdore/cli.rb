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
        json = JSON.parse(stdin)
      rescue JSON::ParserError => e
        puts e.message
        exit 1
      end

      toa = %w(default_attributes override_attributes)

      toa.each do |type|
        attr = json[type]
        prefix = type.split('_').first
        Chefdore::Magic.convert(attr, prefix)
      end
    end

    desc "version", "Display version information"
    def version
      say Chefdore::VERSION
    end
  end
end
