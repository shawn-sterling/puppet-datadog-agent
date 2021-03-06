# Class: datadog_agent::integrations::memcache
#
# This class will install the necessary configuration for the memcache integration
#
# Parameters:
#   $url:
#       url used to connect to the memcached instance
#   $port:
#   $tags
#       Optional array of tags
#
# Sample Usage:
#
# include 'datadog_agent::integrations::memcache'
#
# OR
#
# class { 'datadog_agent::integrations::memcache':
#   url      => 'localhost',
# }
#
# lint:ignore:80chars
class datadog_agent::integrations::memcache (
  $url                    = 'localhost',
  $port                   = 11211,
  $tags                   = [],
  $items                  = false,
  $slabs                  = false,
) inherits datadog_agent::params { # lint:ignore:class_inherits_from_params_class

  include datadog_agent

  validate_string($url)
  validate_array($tags)
  validate_integer($port)

  file { "${datadog_agent::params::conf_dir}/mcache.yaml":
    ensure  => file,
    owner   => $datadog_agent::params::dd_user,
    group   => $datadog_agent::params::dd_group,
    mode    => '0600',
    content => template('datadog_agent/agent-conf.d/mcache.yaml.erb'),
    require => Class['datadog_agent'],
    notify  => Service[$datadog_agent::params::service_name]
  }
# lint:endignore
}
