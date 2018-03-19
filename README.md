Create a single node OpenShift Origin cluster on a CentOS 7 VM through Vagrant. This is intended to be used for a development environment only.

1) Clone the repo

```
$ git clone https://github.com/tkeech1/openshift_vagrant
$ cd openshift_vagrant/
```

2) Start the VM
```
$ vagrant up
```

3) ssh to VM
```
$ vagrant ssh 
```

4) Login to openshift from inside the VM
```
$ oc login -u vagrant -p vagrant https://console.<DOMAIN>:8443/
````

5) Access the web console
```
$ https://console.<DOMAIN>:8443/
```
