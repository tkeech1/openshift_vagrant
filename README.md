Create a single node OpenShift Origin cluster on a CentOS 7 VM through Vagrant. This is intended to be used for a development environment only.

## Clone the repo

'''
$ git clone https://github.com/tkeech1/openshift_vagrant
$ cd openshift_vagrant/
'''

## Start the VM
'''
$ vagrant up
'''

## ssh to VM
'''
$ vagrant ssh 
'''

## Login to openshift from inside the VM
'''
$ oc login -u vagrant -p vagrant https://console.<DOMAIN>:8443/
'''

## Access the web console
'''
$ https://console.<DOMAIN>:8443/
'''
