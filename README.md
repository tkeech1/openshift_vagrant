Create a single node OpenShift Origin cluster on a CentOS 7 VM through Vagrant. This is intended to be used for a development environment only.

# clone the repo
git clone 

cd openshift_vagrant/

# bring up VM
vagrant up

# ssh to VM
vagrant ssh 

# login to openshift from inside the 
oc login -u vagrant -p vagrant https://console.<DOMAIN>:8443/

# web console
https://console.<DOMAIN>:8443/
