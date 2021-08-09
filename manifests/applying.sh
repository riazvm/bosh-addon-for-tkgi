#!/bin/bash

# Login to BOSH by grabbing the Ops Man BOSH Command-line credentials from BOSH Director Tile -> Credentials Tab -> Bosh Commandline Credentials
# and pasting them below (removing the "bosh" cli suffix , you just need the environment variables)

#Example
# export BOSH_CLIENT=ops_manager 
# export BOSH_CLIENT_SECRET=EKcXhxp50TaKjsSEI-HP 
# export BOSH_CA_CERT=/var/tempest/workspaces/default/root_ca_certificate 
# export BOSH_ENVIRONMENT=10.0.0.10

# Ensure the iSCSI release tarball is uploaded to Ops Manager,  this script assumes the filename is iscsi-1.5.tgz
# Upload the iSCSI release tarball to the BOSH director
bosh upload-release ./ethtool_5.4-1.tgz

# Apply the addon in a way that ops man won't overwrite it:
bosh -n update-config --name=ethtool-addon --type=runtime ./pks-manifest.yml

# Then to add this to all existing kubernetes clusters, just re-run the upgrade errand

# bosh -n -d `bosh deployments | grep pivotal-container-service | head -1 | awk '{print $1}'` run-errand upgrade-all-service-instances

# The deployment name for the PKS broker is randomized, the command above assumes you have only one and picks the first one it finds

# This will launch an errand and child deploy tasks for each cluster upgrade.  You can watch the upgrades get kicked off with
# bosh tasks
# bosh task <task #>    
# using ctrl-c to exit the above (task will continue in background)

