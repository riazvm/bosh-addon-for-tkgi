# Tanzu Kubernetes Grid Integrated (TKGI) / Run a shell script when creating a worker node

## What does this do? 

This sample goes thorugh a script that allows creating an add on to bosh that allows to run a script a script on the worker nodes when they are creates.
This specific example  installs the ethtool on the worker nodes and updates the ring buffer size for RX and TX. 

## How do I install it?

1. SSH into opsman
2. Export the BOSH credentials, this can be found in the Metadata section within EPMC or in Opsmanager UI (these are well documented)

e.g.
```
BOSH_CLIENT=ops_manager BOSH_CLIENT_SECRET=ougHtXSkv_3Vi1tOKuA2G-bvSqdq2dP8 BOSH_ENVIRONMENT=172.31.0.3 BOSH_CA_CERT=/var/tempest/workspaces/default/root_ca_certificate bosh 
```

3. Copy or clone this repository onto this BOSH CLI workstation and create+upload the BOSH release to the director

```
git clone https://github.com/riazvm/bosh-addon-for-tkgi && cd bosh-addon-for-tkgi
bosh create-release --force
bosh upload-release ./dev_releases/tkgi-update-ringbuffer/tkgi-update-ringbuffer-0+dev.1.yml

```
4. Configure the addon from this repo
```
bosh -n update-config --name=tkgi-update-ringbuffer --type=runtime ./addon.yml
```
5. Update your TKGI clusters via the PKS CLI and/or Ops Manager "Apply Pending Changes" button with the TKGI upgrade errand enabled.  This addon will automatically be installed on the PKS API VM.



