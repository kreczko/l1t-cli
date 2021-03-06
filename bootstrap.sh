#!/bin/bash
sudo cernvm-update -a
if [ ! -d "/opt/dqm" ]; then
	sudo yum -y install tk compat-readline5 perl-ExtUtils-Embed compat-libstdc++-33 libXmu libXpm
	sudo mkdir -p /opt/dqm/gui
	sudo chown -R vagrant /opt/dqm
	cd /opt/dqm/gui/	
	git clone https://github.com/dmwm/deployment.git
	$PWD/deployment/Deploy -A slc6_amd64_gcc493 -r "comp=comp" -R comp@HG1610a -t MYDEV -s "prep sw post" $PWD dqmgui/bare
fi
source current/apps/dqmgui/128/etc/profile.d/env.sh
$PWD/current/config/dqmgui/manage -f dev start "I did read documentation"
# DQM GUI now available at http://localhost:8060/dqm/dev

sudo mkdir /afs
sudo /sbin/chkconfig afs on
sudo /sbin/service afs start

sudo yum remove cernvm-system

sudo scp -r <>:/opt/cvmfs/ /opt/.
sudo echo "export CMS_LOCAL_SITE=/opt/cvmfs/cms.cern.ch/SITECONF/local" > /etc/cvmfs/config.d/cms.cern.ch.conf
