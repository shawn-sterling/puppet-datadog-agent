# Class: datadog_agent::integrations::mesos_master
#
# This class will install the necessary configuration for the mesos integration
#
# Parameters:
#   $url:
#     The URL for Mesos master
#
# Sample Usage:
#
#   class { 'datadog_agent::integrations::mesos' :
#     url  => "http://localhost:5050"
#   }
#
# lint:ignore:80chars
class datadog_agent::integrations::mesos_master(
  $mesos_timeout = 10,
  $url = 'http://localhost:5050'
) inherits datadog_agent::params { # lint:ignore:class_inherits_from_params_class

  file { "${datadog_agent::params::conf_dir}/mesos.yaml":
    ensure => 'absent'
  }

  file { "${datadog_agent::params::conf_dir}/mesos_master.yaml":
    ensure  => file,
    owner   => $datadog_agent::params::dd_user,
    group   => $datadog_agent::params::dd_group,
    mode    => '0644',
    content => template('datadog_agent/agent-conf.d/mesos_master.yaml.erb'),
    require => Class['datadog_agent'],
    notify  => Service[$datadog_agent::params::service_name]
  }
# lint:endignore
}
