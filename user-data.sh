#!/bin/bash

#Install AWS_CLI
sudo apt-get update
sudo apt-get install -y awscli

#copy license file from S3
aws s3 cp s3://${bucket_name}/license.rli /tmp/license.rli

# create replicated unattended installer config
cat > /etc/replicated.conf <<EOF
{
  "DaemonAuthenticationType": "password",
  "DaemonAuthenticationPassword": "${tfe-pwd}",
  "TlsBootstrapType": "self-signed",
  "LogLevel": "debug",
  "ImportSettingsFrom": "/tmp/replicated-settings.json",
  "LicenseFileLocation": "/tmp/license.rli"
  "BypassPreflightChecks": true
}
EOF

cat > /tmp/tfe_settings.json <<EOF
{
   "aws_instance_profile": {
        "value": "1"
    },
    "enc_password": {
        "value": "${tfe-pwd}"
    },
    "hairpin_addressing": {
        "value": "0"
    },
    "hostname": {
        "value": "${hostname}"
    },
    "pg_dbname": {
        "value": "${db_name}"
    },
    "pg_netloc": {
        "value": "${db_address}"
    },
    "pg_password": {
        "value": "${db_password}"
    },
    "pg_user": {
        "value": "postgres"
    },
    "placement": {
        "value": "placement_s3"
    },
    "production_type": {
        "value": "external"
    },
    "s3_bucket": {
        "value": "${bucket_name}"
    },
    "s3_endpoint": {},
    "s3_region": {
        "value": "${region}"
    }
}
EOF

# install replicated
curl -Ls -o install.sh https://install.terraform.io/ptfe/stable
sudo bash install.sh release-sequence=${tfe_release_sequence}