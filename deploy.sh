#!/bin/bash
# use with Standard D3_V2 Standard (4 cores, 14 GB memory, 200GB disk) flavor for now
#Oracle Linux
yum update -y
yum install -y samba-client samba-common cifs-utils unzip
#Enable the Puppet Package Repository on Linux 6
rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
#Enable the Puppet Package Repository on Linux 7
#sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
#install puppet agent
yum install -y puppet

#mount /oracle home dir
umount /mnt/resource
mkdir /oracle
mount /dev/sdb1 /oracle

#mount installer files to /software
mkdir /software
mount -t cifs //oraclesoftware.file.core.windows.net/installs /software -o vers=3.0,username=oraclesoftware,password=+ZWz5bEk+7XOP7WPt7kYoiVpRR7IrVXbSKgsLEKWLWJXzX7Z+j2hk66iPqkJlhMwKEGbwwMIwOQtMQlAe9To3Q==,dir_mode=0777,file_mode=0777

unzip -o /software/puppet-oradb-install.zip -d /etc/puppet/
#install oracle
puppet apply -e "class {'profile::ora_install_db':}"