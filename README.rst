====================================================
Installation of Bluesky Queue Server (Ansible Roles)
====================================================

This repository currently does not contain any production code

If testing is performed on CentOS VM, run the following playbook
before installing the Redis service::

  ansible-playbook dev/redis_preconfig_centos7.yml -l selected -i dev/hosts -b

Useful script for testing on the VM creates simulated Lustre directory on the local machine
(such as '/nsls2/data/bmm/shared/config/profile_collection')::

  ansible-playbook dev/create_beamline_lustre_dir.yml -l selected -i dev/hosts -b

Production scripts
------------------

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

The ``bluesky_profile_collection_link`` role creates ``~/.ipython/profile_collection``
soft link, which points to the shared location for ``profile_collection`` on Lustre.
The role will not delete the existing ``profile_collection`` directory, but will
replace the existing soft link::

  ansible-playbook bluesky_profile_collection_link_install.yml -l selected -i dev/hosts -b
  ansible-playbook bluesky_profile_collection_link_uninstall.yml -l selected -i dev/hosts -b

The ``qserver_manager_install`` role installs/unistalls Queue Server RE Manager service::

  ansible-playbook qserver_manager_install.yml -l selected -i dev/hosts -b
  ansible-playbook qserver_manager_uninstall.yml -l selected -i dev/hosts -b

The service is started as a beamline user and loads ``.bashrc`` file. Setting
``BS_ENV`` and ``BS_PROFILE`` allows to use different Conda environment or load
startup files from different IPython profile. This is consistent with the behavior
of ``bsui`` in a shell started from beamline user account.
