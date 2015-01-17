module Chefdore
  class Magic
    def self.convert(value={}, prefix="default", path=[])
      if value.is_a?(Hash)
        value.each do |subkey, subval|
          convert(subval, prefix, path+[subkey])
        end
      elsif value.is_a?(Array)
        value.each do |i|
          if i.is_a?(Hash)
            convert(i, prefix, path)
          else
            puts "#{prefix}#{path.map{|p| "['#{p}']"}.join('')} = #{value}"
          end
        end
      else
        puts "#{prefix}#{path.map{|p| "['#{p}']"}.join('')} = '#{value}'"
      end
    end
  end
end
