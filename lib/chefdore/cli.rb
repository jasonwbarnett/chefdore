require 'thor'
require 'chefdore'
require 'json'

module Chefdore
  class Cli < Thor
    namespace "chefdore"

    option :append_arrays,
      type: :boolean,
      desc: "If this is used we will convert arrays by first creating it and then appending each value.",
      aliases: "-a",
      default: false

    map %w(v V -v -V ver --version) => :version

    desc "convert", "Convert Chef Role/Environment to a Chef Cookbook. Expects the json formatted Chef Role/Environment to be piped to this command."
    def convert
      ARGV.replace []
      stdin = ARGF.read

      begin
        Chefdore::Magic.convert(json: stdin, cli: self)
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
