name 'pwnguin'
maintainer 'Justin Dugger'
maintainer_email 'jldugger@gmail.com'
license 'MIT'
description 'Installs/Configures pwnguin.net'
long_description 'Installs/Configures pwnguin.net'
version '0.1.0'

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
# issues_url 'https://github.com/<insert_org_here>/pwnguin/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
# source_url 'https://github.com/<insert_org_here>/pwnguin' if respond_to?(:source_url)

depends 'apache2'
depends 'chef-client'
depends 'postgresql'
