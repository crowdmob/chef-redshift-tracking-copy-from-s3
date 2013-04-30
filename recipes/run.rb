
service 'monit' do
  action :nothing
end

template node[:redshift_tracking_copy_from_s3][:config_file] do
  source  'redshift-tracking-copy-from-s3.properties.erb'
  mode    '0660'
  owner   node[:redshift_tracking_copy_from_s3][:user]
  group   node[:redshift_tracking_copy_from_s3][:group]
  variables(
    :settings         => node[:redshift_tracking_copy_from_s3],
    :env_vars         => node[:redshift_tracking_copy_from_s3][:env],
    :s3_buckets       => node[:redshift_tracking_copy_from_s3][:s3_buckets_array],
    :s3_prefixes      => node[:redshift_tracking_copy_from_s3][:s3_prefixes_array],
    :redshift_tables  => node[:redshift_tracking_copy_from_s3][:redshift_tables_array]
  )
end

template "/usr/local/redshift-tracking-copy-from-s3-daemon" do
  source   'redshift-tracking-copy-from-s3-daemon.erb'
  owner    'root'
  group    'root'
  mode     '0751'
  variables(
    :pid_file     => node[:redshift_tracking_copy_from_s3][:pid_file],
    :config_file  => node[:redshift_tracking_copy_from_s3][:config_file],
    :output_file  => node[:redshift_tracking_copy_from_s3][:output_file]
  )
end

template "#{node[:monit][:conf_dir]}/redshift_tracking_copy_from_s3.monitrc" do
  source   'redshift-tracking-copy-from-s3.monitrc.erb'
  owner    'root'
  group    'root'
  mode     '0644'
  variables(
    :pid_file => node[:redshift_tracking_copy_from_s3][:pid_file]
  )
  notifies :restart, resources(:service => 'monit'), :immediately
end
