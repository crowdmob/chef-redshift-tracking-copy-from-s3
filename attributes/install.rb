default[:redshift_tracking_copy_from_s3][:redshift_schema_json_url] = "http://setmeindatabag/redshift-schema.json"
default[:redshift_tracking_copy_from_s3][:s3_buckets_array] = ["SET-ME-IN-DATABAG"]
default[:redshift_tracking_copy_from_s3][:s3_prefixes_array] = ["SET_ME_IN_DATABAG/"]
default[:redshift_tracking_copy_from_s3][:redshift_tables_array] = ["set_me_in_databags"]
default[:redshift_tracking_copy_from_s3][:redshift_host] = "setmeindatabag"

default[:redshift_tracking_copy_from_s3][:env][:AWS_REGION] = "SET-ME-IN-DATABAG"
default[:redshift_tracking_copy_from_s3][:env][:AWS_ACCESS_KEY_ID] = "SET-ME-IN-DATABAG"
default[:redshift_tracking_copy_from_s3][:env][:AWS_SECRET_ACCESS_KEY] = "SET-ME-IN-DATABAG"
default[:redshift_tracking_copy_from_s3][:env][:REDSHIFT_USER] = "SET-ME-IN-DATABAG"
default[:redshift_tracking_copy_from_s3][:env][:REDSHIFT_PASSWORD] = "SET-ME-IN-DATABAG"

default[:redshift_tracking_copy_from_s3][:remote_tgz] = "https://github.com/crowdmob/redshift-tracking-copy-from-s3/archive/master.tar.gz"
default[:redshift_tracking_copy_from_s3][:version] = "0.1"
default[:redshift_tracking_copy_from_s3][:user] = "redshift_tracking_copy_from_s3"
default[:redshift_tracking_copy_from_s3][:group] = "redshift_tracking_copy_from_s3"
default[:redshift_tracking_copy_from_s3][:pid_files_path] = "/var/run/redshift-tracking-copy-from-s3"
default[:redshift_tracking_copy_from_s3][:output_files_path] = "/var/log/redshift-tracking-copy-from-s3"
default[:redshift_tracking_copy_from_s3][:config_files_path] = "/etc/redshift-tracking-copy-from-s3"
default[:redshift_tracking_copy_from_s3][:pollsleepinseconds] = 60
default[:redshift_tracking_copy_from_s3][:debug] = false
default[:redshift_tracking_copy_from_s3][:sns_failure_notifications] = true
default[:redshift_tracking_copy_from_s3][:sns_topic] = 'redshift-tracking-copy-from-s3'
default[:redshift_tracking_copy_from_s3][:redshift_migrate] = true
default[:redshift_tracking_copy_from_s3][:redshift_port] = 5439
default[:redshift_tracking_copy_from_s3][:redshift_table] = 'dev'
default[:redshift_tracking_copy_from_s3][:redshift_emptyasnull] = true
default[:redshift_tracking_copy_from_s3][:redshift_blanksasnull] = true
default[:redshift_tracking_copy_from_s3][:redshift_fillrecord] = true
default[:redshift_tracking_copy_from_s3][:redshift_maxerror] = 1000
default[:redshift_tracking_copy_from_s3][:redshift_delimiter] = '|'

default[:redshift_tracking_copy_from_s3][:config_file] = "#{node[:redshift_tracking_copy_from_s3][:config_files_path]}/redshift_tracking_copy_from_s3.properties"
default[:redshift_tracking_copy_from_s3][:pid_file] = "#{node[:redshift_tracking_copy_from_s3][:pid_files_path]}/redshift_tracking_copy_from_s3.pid"
default[:redshift_tracking_copy_from_s3][:output_file] = "#{node[:redshift_tracking_copy_from_s3][:output_files_path]}/redshift_tracking_copy_from_s3.out"