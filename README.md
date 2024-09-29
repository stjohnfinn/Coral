# Coral Provisioning

This repository stores all of the ansible necessary to provision a Fedora installation 
to fit my standards and preferences.

## How to use

### Testing

From the root of the project:

    vagrant up 

and then:

    vagrant provision

each time you make a change.

### Deployment

You can clone the repository and then you can just run the ansible locally against the 
machine you are provisioning. So this kind of assumes you have a browser or something. 
I guess I'm okay with that.

Anyways, to run it against the local system, you can use:

    ansible-playbook ./playbook.yml --ask-become-pass -i ./inventory.yml

It will prompt you for the root (or equivalent privileged account) password, 
which you should know because you just installed Fedora and set root password. 
Additionally, this method assumes you are running it against localhost, but 
maybe that's not the case. It's probably easier and more Ansible-ic to run it 
from a controller node that isn't localhost. The inventory file `inventory.yml` 
makes this easy.

**Warning**: there are requirements for the target system. Obviously, the 
Ansible must be executed by a user with elevated permissions. In the Vagrant VM,
this is the `vagrant` user. In a real system, I'd rather not create a `vagrant`
user just for that purpose. Instead, you can either just create your personal 
account, which is probably named `finn`, or you can create a housekeeping 
account like `maintenance` or `installer`. 

## Notes

This repository must always be private. There are real secrets stored in here that 
should never be publicized.
