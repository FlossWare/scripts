# Red Hat Based Provisioning
The Ansible [playbooks](http://docs.ansible.com/ansible/playbooks.html) and [roles](http://docs.ansible.com/ansible/playbooks_roles.html#roles) found here are solely for configuring Red Hat based systems.

## Concepts

### Playbooks
There are a few playbooks included that highlight some common use cases we've used.  More concrete examples can be found in [Flossy's](https://github.com/sfloess) [home script git repo](https://github.com/sfloess/scripts/tree/master/ansible).

### Roles
For the most part, most roles are mutually exclusive and do "a thing."  However, we do utilize [dependent roles](http://docs.ansible.com/ansible/playbooks_roles.html#role-dependencies) where two or more roles leverage the same functionality.  There are some exceptions to this rule - notably the ```common/bridge``` role stands on its own.

#### Sub Roles
We make liberal use of directory structures to leverage the notion of a sub role.  While technically these are roles unto themselves, having a cohesive directory structure elliminates "interesting" naming convention.  As an example, our initial effort had directories like:
* centosXen
* centosXenVirtualization

By using subdirectories, we have much clearer (and cleaner) naming conventions.  To illustrate, we fixed the aforementioned by defining sub roles as:
* [operatingSystem/centos/xen](https://github.com/FlossWare/scripts/tree/master/ansible/redhat/roles/operatingSystem/centos/xen)
* [cloud/virtualization](https://github.com/FlossWare/scripts/tree/master/ansible/redhat/roles/cloud/virtualization)

#### Dependent Roles
As mentioned above, we only utilize [dependent roles](http://docs.ansible.com/ansible/playbooks_roles.html#role-dependencies) when two or more roles leverage a common piece of functionality.  As an example both ```cloud/kvm``` and ```operatingSystem/cents/xen``` require the same "virtualization" functionality.

#### Layout
Our current layout consists of:
* [cloud](https://github.com/FlossWare/scripts/tree/master/ansible/redhat/roles/cloud): these are cloud-y kind of roles like [virtualization](https://en.wikipedia.org/wiki/Virtualization) and [Cobbler](http://cobbler.github.io/).
* [common](https://github.com/FlossWare/scripts/tree/master/ansible/redhat/roles/common): common functionality one might use for things like email servers, setting up [autofs](https://wiki.archlinux.org/index.php/Autofs), etc.
* [operatingSystem](https://github.com/FlossWare/scripts/tree/master/ansible/redhat/roles/operatingSystem): breaking up specific operating system roles for CentOS and RHEL (like [Subscription Manager](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/5/html/5.7_Release_Notes/subscriptionentitlement.html) functionality).

## How To
Presently the only way to utilize our scripts is to clone this git repo.  Simply do so and add the cloned directory to your ```/etc/ansible/ansible.cfg``` ```roles_path```.  For example:  ```roles_path = /home/sfloess/Development/github/FlossWare/scripts/ansible/redhat/roles```

## Documentation
Please see the [wiki pages](https://github.com/FlossWare/scripts/wiki) for descriptions of roles and playbooks.
