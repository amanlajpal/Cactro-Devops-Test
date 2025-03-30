# Steps that I followed

1. Launch EC2 Instance
    1. Select AMI - Amazon Linux
    2. Select Instance Type - t2.micro 
    3. Create Key Pair
    4. Create Security Group
        * Allow SSH Traffic - Select My IP
    5. Click Launch Instance on Bottom right
2. Go To Instances
    1. Select Instance Recently Created
    2. Click Connect Button on Top Right
    3. On SSH Client tab
        - Copy example connection string
3. Connect to Instance
    1. Open Git bash from directory which contains key-pair.pem file or any other command line interface of your choice
    2. And paste copied connection string in our last step on git bash
    3. run the pasted command
    4. enter yes when prompted for following
    5. Are you sure you want to continue connecting (yes/no/[fingerprint])
    6. Now you will see something like this which means you are connected to your instance.[ec2-user@ip-172-31-7-185 ~]$
4. Install AWS CLI latest version in ec2
    1. Remove awscli previous version by following command
        * ```sudo yum remove awscli```
        * when it will ask for yes or no, type yes and enter 
    2. To install Command line installer - Linux x86 (64-bit) type following command
        * <code>curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" - "awscliv2.zip"
            unzip awscliv2.zip
            sudo ./aws/install</code>
    3. Check the version installed by following command
        * ``` aws --version ```
5. Create script and run to create var/log/app.log file to simulate application log file
    1. ```touch simulate-app-logs.sh``` 
    2. ```chmod +x simulate-app-logs.sh``` 
    3. ```nano simulate-app-logs.sh``` 
        - Copy script mentioned in simulate-app-logs.sh in current directory of this repository
        - Paste in nano editor
        - Press Ctrl O
        - Press Enter
        - Press Ctrl X
    4. Run script by ```./simulate-app-logs.sh```
6. Create S3 bucket
    1. Select Enable Bucket Version radio button
    2. Let other be default selections
    3. Click Create bucket button
7. Create IAM Role to give access of S3 to EC2
    1. Go To IAM > Policies
    2. Copy Amazon Resource Name (ARN) for S3 by
        - going to S3 on new tab
        - Open Respective Bucket
        - go to properties
        - copy ARN
    3. Create Policy
        - Select S3
        - Check ListBucket from List Access Level
        - Check GetObject from Read Access Level
        - Check PutObject from Write Access Level
        - In Resources Section Add S3 Arn and select any object checkbox
        - Click Next
        - Give policy a name 
        - Click Create Policy Button
    4. Go to IAM > Roles
    5. Create Role
        - Select AWS Service
        - In use case select EC2
        - Click Next
        - Now, search and select recently created policy by it's name and click next
        - Give Role a name, description and click create role
8. Now let's Attach IAM role created recently to our Ec2 instance
    1. Go to Instances > Select Our Ec2 instance
    2. Open Actions dropdown on top right 
    3. Click Security within dropdown
    4. Then click Modify IAM Role from Security Sub Dropdown
    5. Select IAM Role that we created in previous step
    6. Click Update IAM Role
9. Create script to upload app logs (/var/log/app.log) to s3
    1. ```touch upload-app-logs.sh``` 
    2. ```chmod +x upload-app-logs.sh``` 
    3. ```nano upload-app-logs.sh``` 
        - Copy script mentioned in upload-app-logs.sh in current directory of this repository
        - Paste in nano editor
        - Press Ctrl O
        - Press Enter
        - Press Ctrl X
    4. Run script by ```./upload-app-logs.sh```
10. Install and Add 2 Cron Jobs by following steps that runs to add dummy logs every minute and daily at 12:00 to upload app dummy logs to s3
    1. Install cronie by ```sudo yum install cronie cronie-anacron```
    2. ```sudo systemctl enable crond```
    3. ```sudo systemctl start crond```
    3. Check whether it's running ```sudo systemctl status crond```
    4. Create log file to store script logs triggered by cron
    5. ```touch ~/log-creation-script.log```
    5. ```touch ~/upload-application-logs-to-s3-script.log```
    6. ```sudo crontab -e``` 
    7. press i and paste below 2 lines
    8. ```*/2 * * * * /usr/bin/sudo /home/ec2-user/simulate-app-logs.sh >> /home/ec2-user/log-creation-script.log 2>&1```
    9. ```0 0 * * * /usr/bin/sudo /home/ec2-user/upload-app-logs.sh >> /home/ec2-user/upload-application-logs-to-s3-script.log 2>&1```
    10. then press escape :wq to save and exit
    

# How to test the upload.

1. To test the upload go to s3 and check for specific date folder and log file inside it
2. To test the cron, test it by running it every minute
3. To test script files, test them running manually instead of cron for debugging and testing purposes
4. To test commands in script file, run individual commands in terminal

# Where to find the uploaded logs in S3.

1. bucketname/yyyy-mm-dd/app.log.gz
2. in my case it's https://cactro-devops-test.s3.ap-south-1.amazonaws.com/logs/2025-03-30/app.log.gz


    
        



        
    

        
