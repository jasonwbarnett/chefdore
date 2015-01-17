#!/usr/bin/env ruby
$:.unshift("#{File.dirname(__FILE__)}/../lib")
require 'chefdore'

my_stuff = {
  'deep' => {
    'hash' => {
      'with' => 'a',
      'bunch' => 'of',
    },
    'stuff' => 'yay!',
    'gems' => [ {'one' => 'boober'}, {'to' => 'another'} ],
  },
}

Chefdore::Magic.convert(my_stuff)

