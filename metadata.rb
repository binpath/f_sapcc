name 'f_sapcc'
maintainer 'Cesar Felce'
maintainer_email 'cfelce@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures f_sapcc'
long_description 'Installs/Configures f_sapcc'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/f_sapcc/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/f_sapcc'

depends 'aws'