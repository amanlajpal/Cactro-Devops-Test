#!/bin/bash

echo "Uploading applications logs"
sudo gzip -k /var/log/app.log
echo "Log Zip Created"
aws s3 cp /var/log/app.log.gz s3://cactro-devops-test/logs/$(date --date="yesterday" +%F)/
sudo rm -rf /var/log/app.log.gz
echo "Log file uploaded to S3"
