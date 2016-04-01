name             'stig'
maintainer       'USGS WSI'
maintainer_email 'isuftin@usgs.gov'
license          'Public domain'
description      'Installs/Configures CIS STIG benchmarks'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.9'

supports         'centos', '>= 6.6'
supports         'centos', '>= 7.1'
supports         'ubuntu'

suggests		 "auditd", "~> 0.1.8"

depends			 "logrotate", "~> 1.9.2"
