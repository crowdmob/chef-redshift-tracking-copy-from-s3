Redshift Tracking Copy from S3 Cookbook for Amazon OpsWorks
===============================

Chef Cookbook that downloads the `crowdmob/redshift-tracking-copy-from-s3` repository from GitHub, builds, and runs it using monit. Confirmed working with Amazon OpsWorks.

Dependencies
-----------------------------
This cookbook depends on the following:

- `golang`: the installation of go recipe at https://github.com/crowdmob/chef-golang
- `monit`: the monit package to ensure your server is running, and tries to restart it if not at https://github.com/crowdmob/chef-monit


Custom Chef Recipes Setup
-----------------------------
To deploy your app, you'll have to make sure 2 of the recipes in this cookbook are run.

1. `redshift-tracking-copy-from-s3::install` should run during the setup phase of your node in OpsWorks
2. `redshift-tracking-copy-from-s3::run` should run after redshift-tracking-copy-from-s3::install, possibly in the Configure phase of your node in OpsWorks.

Databag Setup
-----------------------------
This cookbook relies on a databag, which you should set in Amazon OpsWorks as your Stack's "Custom Chef JSON", with the following parameters:

```json
{
  "service_realm": "production",
  "redshift_tracking_copy_from_s3": {
    "env": {
      "AWS_ACCESS_KEY_ID": "YOUR_AWS_ACCESS_KEY_CREDENTIALS",
      "AWS_SECRET_ACCESS_KEY": "YOUR_AWS_SECRET_KEY_CREDENTIALS",
      "AWS_REGION": "us-east-1",
      ...
    }
  }
}
```

Here's a little more about the ones you have to fill in:
- `YOUR_AWS_ACCESS_KEY_CREDENTIALS` should be gotten from Amazon AWS
- `YOUR_AWS_SECRET_KEY_CREDENTIALS` should also be gotten from Amazon AWS

How it Works
-----------------------------
This cookbook builds and runs a go webapp in the following way:

- The `main.go` source file from https://github.com/crowdmob/redshift-tracking-copy-from-s3 is built using `go get .` followed by `go build -o /usr/local/redshift-tracking-copy-from-s3 main.go`.  That results in an executable of at  `/usr/local/redshift-tracking-copy-from-s3`
- A `redshift-tracking-copy-from-s3.properties` file is created using your databag and output at `/etc/redshift-tracking-copy-from-s3/redshift_tracking_copy_from_s3.properties`
- A `redshift-tracking-copy-from-s3-daemon` shell script is created and placed in  `/usr/local/`, which handles start and restart commands, by calling  `/usr/local/redshift-tracking-copy-from-s3 -c /etc/redshift-tracking-copy-from-s3/redshift_tracking_copy_from_s3.properties` and outputting logs to `/var/log/redshift-tracking-copy-from-s3/redshift_tracking_copy_from_s3.out`
- A `redshift_tracking_copy_from_s3.monitrc` monit script is created, which utilizes the `redshift-tracking-copy-from-s3-daemon` script for startup and shutdown, and is placed in `/etc/monit.d` or `/etc/monit/conf.d`, depending on your OS (defined in the `monit` cookbook)
- `monit` is restarted, which incorporates the the new files.


License and Author
===============================
Author:: Matthew Moore

Copyright:: 2013, CrowdMob Inc.


Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
