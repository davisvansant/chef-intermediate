#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "httpd" do
  action :install
end

# Disable the default virtual host
apache_vhost "welcome" do
  action :remove
  notifies :restart, "service[httpd]"
end

# Iterate over the apache sites
search("apache_sites", "*:*").each do |site|
  apache_vhost site['id'] do
    site_port site['port']
    action :create
    notifies :restart, "service[httpd]"
  end
end

service "httpd" do
  action [ :enable, :start ]
end

ruby_block "randomly_choose_language" do
  block do
    if Random.rand > 0.5
      node.run_state['scripting_language'] = 'php'
    else
      node.run_state['scripting_language'] = 'perl'
    end
  end
end

package "scripting language" do
  package_name lazy { node.run_state['scripting_language'] }
  action :install
end
