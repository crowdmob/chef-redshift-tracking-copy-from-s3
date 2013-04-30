group node[:redshift_tracking_copy_from_s3][:group]

user node[:redshift_tracking_copy_from_s3][:user] do
  comment   "redshifttrackingcopyfroms3 user"
  gid       node[:redshift_tracking_copy_from_s3][:group]
  home      "/home/#{node[:redshift_tracking_copy_from_s3][:user]}"
  shell     "/bin/noshell"
  supports  :manage_home => false
end

bash "install-redshift-tracking-copy-from-s3-master" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    rm -rf redshift-tracking-copy-from-s3
    rm -rf /usr/local/redshift-tracking-copy-from-s3
    tar -xzvf redshift-tracking-copy-from-s3-master.tar.gz
    #{node['go']['install_dir']}/go/bin/go get ./redshift-tracking-copy-from-s3-master
    #{node['go']['install_dir']}/go/bin/go build -o /usr/local/redshift-tracking-copy-from-s3 redshift-tracking-copy-from-s3-master/main.go
  EOH
  action :nothing
end

remote_file File.join(Chef::Config[:file_cache_path], "redshift-tracking-copy-from-s3-master.tar.gz") do
  source          node[:redshift_tracking_copy_from_s3][:remote_tgz]
  owner           "root"
  mode            0644
  notifies        :run, resources(:bash => "install-redshift-tracking-copy-from-s3-master"), :immediately
  not_if          "/usr/local/redshift-tracking-copy-from-s3 -v | grep #{node[:redshift_tracking_copy_from_s3][:version]}"
end

[node[:redshift_tracking_copy_from_s3][:pid_files_path], node[:redshift_tracking_copy_from_s3][:config_files_path], node[:redshift_tracking_copy_from_s3][:output_files_path]].each do |my_dir|
  directory my_dir do
    group      "root"
    owner      "root"
    mode       0770
    action     :create
    recursive  true
  end
end
