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

example = {
     "developer_mode" => false,
             "glance" => {
    "image_upload" => true,
          "images" => [
      "cirros",
      "precise"
    ]
  },
         "monitoring" => {
     "metric_provider" => "collectd",
    "procmon_provider" => "monit"
  },
              "mysql" => {
    "allow_remote_root" => true,
     "root_network_acl" => "%"
  },
               "nova" => {
      "libvirt" => {
      "virt_type" => "qemu"
    },
     "networks" => {
      "private" => {
            "bridge" => "br101",
        "bridge_dev" => "eth0.101",
              "dns1" => "8.8.8.8",
              "dns2" => "8.8.4.4",
         "ipv4_cidr" => "172.16.101.0/24",
             "label" => "private"
      },
       "public" => {
            "bridge" => "br100",
        "bridge_dev" => "eth0.100",
              "dns1" => "8.8.8.8",
              "dns2" => "8.8.4.4",
         "ipv4_cidr" => "10.10.100.0/24",
             "label" => "public"
      }
    },
    "ratelimit" => {
         "api" => {
        "enabled" => true
      },
      "volume" => {
        "enabled" => true
      }
    }
  },
     "osops_networks" => {
    "management" => "192.168.1.0/24",
          "nova" => "192.168.1.0/24",
        "public" => "192.168.1.0/24"
  },
  "package_component" => "folsom"
}

Chefdore::Magic.convert(my_stuff, "my_stuff")
Chefdore::Magic.convert(example, "example")

