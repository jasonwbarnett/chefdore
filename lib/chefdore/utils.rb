require 'chef/role'
require 'chef/json_compat'

module Chefdore
  class Magic


    def self.convert_run_list(opts = {})
      rl  = opts[:run_list] ? opts[:run_list] : []
      cli = opts[:cli]      ? opts[:cli]      : Chefdore::Cli.new

      rl.recipes.each do |x|
        puts "include_recipe #{x.inspect}"
      end
    end


    def self.convert_attr(opts = {})
      value  = opts[:value]
      prefix = opts[:prefix] ? opts[:prefix] : "default"
      path   = opts[:path]   ? opts[:path]   : []
      cli    = opts[:cli]    ? opts[:cli]    : Chefdore::Cli.new

      #puts "DEBUG :: #{prefix} -- #{path} -- #{value.inspect} (#{value.class})"

      if value.is_a?(Hash) and value.empty? and path.empty?
        nil
      elsif value.is_a?(Hash)
        # This allows us to include empty hashes if one is found
        puts "#{prefix}#{path.map{|p| "[#{p.inspect}]"}.join('')} = #{value.inspect}" if value.empty?

        value.each do |subkey, subval|
          convert_attr(opts.merge(value: subval, path: path+[subkey]))
        end
      elsif value.is_a?(Array) && cli.options[:append_arrays]
        puts "#{prefix}#{path.map{|p| "[#{p.inspect}]"}.join('')} = #{Array.new.inspect}"
        value.each do |x|
          puts "#{prefix}#{path.map{|p| "[#{p.inspect}]"}.join('')} << #{x.inspect}"
        end
      else
        puts "#{prefix}#{path.map{|p| "[#{p.inspect}]"}.join('')} = #{value.inspect}"
      end
    end


    def self.convert(opts = {})
      json = opts[:json] ? opts[:json] : fail("You must pass some JSON in :json opt")
      cli  = opts[:cli]  ? opts[:cli]  : fail("You must pass the CLI in :cli opt")
      klass = Chef::JSONCompat.from_json(json)

      rl = klass.run_list
      da = klass.default_attributes
      oa = klass.override_attributes

      puts "## Place the following in your cookbook in attributes/default.rb"
      convert_attr(cli: cli, value: da)
      puts

      puts "## Place the following in your cookbook in attributes/overrides.rb (alternatively, you may place these in attributes/default.rb instead)"
      convert_attr(cli: cli, value: oa, prefix: "override")
      puts

      puts "## Place the following in your cookbook in recipes/default.rb"
      convert_run_list(cli: cli, run_list: rl)
    end


  end
end
