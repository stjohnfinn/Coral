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

    ansible-playbook ./playbook.yml --ask-become-pass

It will prompt you for the root password, which you should know because you just 
installed Fedora and set root password. Additionally, this method assumes you are running
it against localhost, but maybe that's not the case. It's probably easier and more 
Ansible-ic to run it from a controller node that isn't localhost. Eventually, there will
be a way to do this easily.

## Notes

This repository must always be private. There are real secrets stored in here that 
should never be publicized.
