#!/bin/bash
tag=$1
env=$2

IP=`grep $env env.properties | cut -d ':' -f2 |tr -d "[:space:]"`
mkdir /var/lib/jenkins/practice
cd /var/lib/jenkins/practice
aws s3 cp s3://jenkins-test-8/java_code8/$tag/wwp-1.0.0.war .
scp wwp-1.0.0.war ec2-user@${IP}:/home/ec2-user/tomcat/apache-tomcat-9.0.64/webapps
 ssh ec2-user@${IP} << HERE
    rm -rf /home/ec2-user/tomcat/apache-tomcat-9.0.64/work
    cd /home/ec2-user/tomcat/apache-tomcat-9.0.64/bin/
    ./shutdown.sh
    ./startup.sh
HERE        