# Chefdore

Chef tool that was named after Dumbledore.

I created this gem in order to help those who may want to convert Chef Roles to Chef Cookbooks.

## Installation

    $ gem install chefdore

## Usage

Let's say you have a Chef Role in your Chef Server and you want to convert it to a Chef Cookbook.

First let's take a look at an "example_role":

```bash
$ knife role show example_role --format json
{
  "name": "example_role",
  "description": "Chef-server example role",
  "json_class": "Chef::Role",
  "default_attributes": {

  },
  "override_attributes": {
    "developer_mode": false,
    "monitoring": {
      "metric_provider": "collectd",
      "procmon_provider": "monit"
    },
    "glance": {
      "image_upload": true,
      "images": [
        "cirros",
        "precise"
      ]
    },
    "nova": {
      "ratelimit": {
        "api": {
          "enabled": true
        },
        "volume": {
          "enabled": true
        }
      },
      "libvirt": {
        "virt_type": "qemu"
      },
      "networks": {
        "public": {
          "label": "public",
          "ipv4_cidr": "10.10.100.0/24",
          "bridge": "br100",
          "bridge_dev": "eth0.100",
          "dns1": "8.8.8.8",
          "dns2": "8.8.4.4"
        },
        "private": {
          "label": "private",
          "ipv4_cidr": "172.16.101.0/24",
          "bridge": "br101",
          "bridge_dev": "eth0.101",
          "dns1": "8.8.8.8",
          "dns2": "8.8.4.4"
        }
      }
    },
    "mysql": {
      "allow_remote_root": true,
      "root_network_acl": "%"
    },
    "osops_networks": {
      "nova": "192.168.1.0/24",
      "public": "192.168.1.0/24",
      "management": "192.168.1.0/24"
    },
    "package_component": "folsom"
  },
  "chef_type": "role",
  "run_list": [

  ],
  "env_run_lists": {

  }
}
```

All we have to do is pipe that output into our little command line client:

```bash
$ knife role show example_role --format json | chefdore convert
override["developer_mode"] = false
override["monitoring"]["metric_provider"] = "collectd"
override["monitoring"]["procmon_provider"] = "monit"
override["glance"]["image_upload"] = true
override["glance"]["images"] = ["cirros", "precise"]
override["glance"]["images"] = ["cirros", "precise"]
override["nova"]["ratelimit"]["api"]["enabled"] = true
override["nova"]["ratelimit"]["volume"]["enabled"] = true
override["nova"]["libvirt"]["virt_type"] = "qemu"
override["nova"]["networks"]["public"]["label"] = "public"
override["nova"]["networks"]["public"]["ipv4_cidr"] = "10.10.100.0/24"
override["nova"]["networks"]["public"]["bridge"] = "br100"
override["nova"]["networks"]["public"]["bridge_dev"] = "eth0.100"
override["nova"]["networks"]["public"]["dns1"] = "8.8.8.8"
override["nova"]["networks"]["public"]["dns2"] = "8.8.4.4"
override["nova"]["networks"]["private"]["label"] = "private"
override["nova"]["networks"]["private"]["ipv4_cidr"] = "172.16.101.0/24"
override["nova"]["networks"]["private"]["bridge"] = "br101"
override["nova"]["networks"]["private"]["bridge_dev"] = "eth0.101"
override["nova"]["networks"]["private"]["dns1"] = "8.8.8.8"
override["nova"]["networks"]["private"]["dns2"] = "8.8.4.4"
override["mysql"]["allow_remote_root"] = true
override["mysql"]["root_network_acl"] = "%"
override["osops_networks"]["nova"] = "192.168.1.0/24"
override["osops_networks"]["public"] = "192.168.1.0/24"
override["osops_networks"]["management"] = "192.168.1.0/24"
override["package_component"] = "folsom"
```

It outputs exactly what should be dropped into your new Chef Cookbook attributes file.
e.g. `attributes/default.rb`

## Contributing

1. Fork it ( https://github.com/jasonwbarnett/chefdore/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License & Authors
- Author: Jason Barnett

```
Copyright (c) 2015 Jason Barnett

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
