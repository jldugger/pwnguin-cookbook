name 'pwnguin'
maintainer 'Justin Dugger'
maintainer_email 'jldugger@gmail.com'
license 'GPL-2.0'
description 'Installs/Configures pwnguin.net'
long_description 'Installs/Configures pwnguin.net'
version '1.2.0'

chef_version '>= 12.5' if respond_to?(:chef_version)
supports 'ubuntu'

issues_url 'https://github.com/jldugger/pwnguin/issues' if respond_to?(:issues_url)
source_url 'https://github.com/jldugger/pwnguin' if respond_to?(:source_url)

depends 'acme'
depends 'apache2'
depends 'chef-client'
depends 'postgresql'
depends 'database'
depends 'application_python'
depends 'application_git'
depends 'build-essential'
depends 'logrotate'
