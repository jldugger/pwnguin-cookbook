name 'pwnguin'
maintainer 'Justin Dugger'
maintainer_email 'jldugger@gmail.com'
license 'MIT'
description 'Installs/Configures pwnguin.net'
long_description 'Installs/Configures pwnguin.net'
version '1.0.3'

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
