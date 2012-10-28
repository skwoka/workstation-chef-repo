#!/bin/bash

#
# Bootstrap chef to a node and configure it.
#

DRYRUN=false
#DRYRUN=true

function run {
  if [[ $DRYRUN == true ]];
  then
    echo "***DRY RUN*** $@"
  else
    $@
  fi
}

function install_chef {
	echo "Installing chef..."
	DOWNLOADER="curl -L "
	which curl > /dev/null
	if [ $? -ne 0 ]
	then
    DOWNLOADER="wget -qO- "
	fi
#	run "curl -L http://opscode.com/chef/install.sh | sudo bash"
# run wget -qO- http://opscode.com/chef/install.sh | sudo bash
  run $DOWNLOADER http://opscode.com/chef/install.sh | sudo bash
}

# http://jtimberman.housepub.org/blog/2012/07/29/os-x-workstation-management-with-chef/
install_chef

chef-solo -c solo.rb -j linux.dna.json -l debug
