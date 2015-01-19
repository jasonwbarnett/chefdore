require 'chef/role'
require 'chef/json_compat'

module Chefdore
  class Magic


    def self.convert_attr(opts = {})
      value  = opts[:value]
      prefix = opts[:prefix] ? opts[:prefix] : "default"
      path   = opts[:path]   ? opts[:path]   : []
      cli    = opts[:cli]    ? opts[:cli]    : Chefdore::Cli.new

      #puts "INFO :: #{value.inspect} (#{value.class}) -- #{prefix} -- #{path}"

      if value.is_a?(Hash)
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
      role = Chef::JSONCompat.from_json(json)

      rl = role.run_list
      da = role.default_attributes
      oa = role.override_attributes

      convert_attr(cli: cli, value: da)
      convert_attr(cli: cli, value: oa, prefix: "override")
    end


  end
end
