require 'chef/role'
require 'chef/json_compat'

module Chefdore
  class Magic


    def self.convert_attr(value={}, prefix="default", path=[])
      #puts "INFO :: #{value.inspect} (#{value.class}) -- #{prefix} -- #{path}"

      if value.is_a?(Hash)
        value.each do |subkey, subval|
          convert_attr(subval, prefix, path+[subkey])
        end
      elsif value.is_a?(Array)
        value.each do |i|
          if i.is_a?(Hash)
            convert_attr(i, prefix, path)
            value.delete i
          end
        end
        puts "#{prefix}#{path.map{|p| "[#{p.inspect}]"}.join('')} = #{value.inspect}"
      else
        puts "#{prefix}#{path.map{|p| "[#{p.inspect}]"}.join('')} = #{value.inspect}"
      end
    end


    def self.convert(json={})
      role = Chef::JSONCompat.from_json(json)

      rl = role.run_list
      da = role.default_attributes
      oa = role.override_attributes

      convert_attr(da)
      #convert_attr(oa, "override")
    end


  end
end
