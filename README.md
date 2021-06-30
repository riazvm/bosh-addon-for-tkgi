# Tanzu Kubernetes Grid Integrated (TKGI) / Run a shell script when creating a worker node

## What does this do?

Runs a script to install the ethtool on the worker nodes and updates the ring buffer size for RX and TX

## How do I install it?

1. Open a shell prompt on a BOSH CLI with access to your TKGI bosh director, such as Ops Manager.
2. Export your BOSH credentials to the enviornment.  These can be accessed via the Ops Manager GUI -> BOSH Director Tile -> Credentials Tab -> Bosh Commandline Credentials. or from the EPMC console Metadata section  

e.g.
```
BOSH_CLIENT=ops_manager BOSH_CLIENT_SECRET=ougHtXSkv_3Vi1tOKuA2G-bvSqdq2dP8 BOSH_ENVIRONMENT=172.31.0.3 BOSH_CA_CERT=/var/tempest/workspaces/default/root_ca_certificate bosh 
```
3. Copy or clone this repository onto this BOSH CLI workstation and create+upload the BOSH release to the director

```
git clone https://github.com/riazvm/bosh-addon-for-tkgi && cd tkgi-pre-run-scipt
bosh create-release --force
bosh upload-release ./dev_releases/tkgi-pre-run-scipt/tkgi-pre-run-scipt-0+dev.1.yml

```
4. Configure the addon from this repo
```
bosh -n update-config --name=tkgi-pre-run-scipt --type=runtime ./addon.yml
```
5. Update your TKGI clusters via the PKS CLI and/or Ops Manager "Apply Pending Changes" button with the TKGI upgrade errand enabled.  This addon will automatically be installed on the PKS API VM.



