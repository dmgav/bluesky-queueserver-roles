====================================================
Installation of Bluesky Queue Server (Ansible Roles)
====================================================

This repository currently does not contain any production code

If testing is performed on CentOS VM, run the following playbook
before installing the Redis service::

  ansible-playbook dev/redis_preconfig_centos7.yml -l selected -i dev/hosts -b

The ``qserver_redis_install`` playbook install Redis (if it is not already installed),
starts and enables the default Redis service (``redis.service``, port 6379), installs,
starts and enables the second Redis service (``redis-qserver.service``, port 60590)::

  ansible-playbook qserver_redis_install.yml -l selected -i dev/hosts -b

The ``redis-qserver.service`` is expected to be used for running production
instance of Queue Server and ``redis.service`` for testing, prototyping
as well as for other standard applications that require Redis.

The ``qserver_redis_uninstall`` playbook stops, disables and removes
the ``redis-qserver.service``, including ``.service`` and ``.conf`` files.
The dumped database and logs remain on the host::

  ansible-playbook qserver_redis_uninstall.yml -l selected -i dev/hosts -b
