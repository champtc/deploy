#!/usr/bin/bash

#download dependencies
yum install -y wget git

#install chef
wget https://packages.chef.io/files/stable/chefdk/2.4.17/el/7/chefdk-2.4.17-1.el7.x86_64.rpm
yum install chefdk-2.4.17-1.el7.x86_64.rpm -y

#create chef-repo
chef generate repo /tmp/chef-repo

#update knife.rb
mkdir /root/.chef
echo "cookbook_path [ '/tmp/chef-repo/cookbooks/' ]" > /root/.chef/knife.rb

#clone cookbooks
cd /tmp/chef-repo/cookbooks
git clone https://github.com/champtc/dl-elk.git
git clone https://github.com/champtc/dl-amq.git

#run cookbooks
chef-client -z -r dl-elk
chef-client -z -r dl-amq