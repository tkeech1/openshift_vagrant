Create a single node OpenShift Origin cluster on a CentOS 7 VM through Vagrant. This is intended to be used for a development environment only.

1) Clone the repo

```
$ git clone https://github.com/tkeech1/openshift_vagrant
$ cd openshift_vagrant/
```

2) Replace variable placeholders in the Vagrantfile. Search for instances of 'REPLACE' and provide values.

3) Start the VM
```
$ vagrant up
```

4) ssh to VM
```
$ vagrant ssh 
```

5) Login to openshift from inside the VM
```
$ oc login -u vagrant -p vagrant https://console.<DOMAIN>:8443/
````

6) Access the web console
```
$ https://console.<DOMAIN>:8443/
```
