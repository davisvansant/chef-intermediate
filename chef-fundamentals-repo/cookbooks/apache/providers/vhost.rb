use_inline_resources

action :create do
  # set the docuemnt root
  document_root = "/srv/apache/#{new_resource.site_name}"

  # add a template for apache virtual host configuration
  template "/etc/httpd/conf.d/#{new_resource.site_name}.conf" do
    source "custom.erb"
    mode "0644"
    variables(
      :document_root => document_root,
      :port => new_resource.site_port
    )
  end

  directory document_root do
    mode "0755"
    recursive true
  end

  # add a template resource for the virtual host's index.html
  template "#{document_root}/index.html" do
    source "index.html.erb"
    mode "0644"
    variables(
      :site_name => new_resource.site_name,
      :port => new_resource.site_port
    )
  end
end

action :remove do
  file "/etc/httpd/conf.d/#{new_resource.site_name}.conf" do
    action :delete
  end
end
