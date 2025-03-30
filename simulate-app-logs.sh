#!/bin/bash
sudo touch /var/log/app.log
sudo bash -c "cat >> /var/log/app.log <<EOL
$(date) line 1,
$(date) line 2,
$(date) line 3,
$(date) line 4,
$(date) line 5
EOL"
echo "log created sucessfully"