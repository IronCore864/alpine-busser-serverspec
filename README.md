# Alpine linux with ansible, ruby, gem, busser, serverspec, for faster test-kitchen usage.

Ideal for test-kitchen, with docker as driver, ansible as provisioner, and busser/serverspec as verifier.

Note that Chef does not support alpine, so Chef can not be used as a provisioner with this docker.

This is mainly for Ansible as provisioner. If kitchen-ansible provisioner is used, you can choose not to install chef by setting `require_chef_for_busser` to False.

Example:

    provisioner:
      name: ansible_playbook
      require_chef_for_busser: false

Default verifier of kitchen is busser, so by default kitchen will install Chef, just to use the embedded ruby and gem to install busser.

If you use other verifiers, Chef is not needed at all.

But if you still want to have the capability and simplicity to use busser, this image does it for you since it is based on ruby:alpine with busser and serverspec installed.

`.kitchen.yml` example:

    ---
    driver:
      name: docker
    
    provisioner:
      name: ansible_playbook
      hosts: test-kitchen
      ansible_version: latest
      roles_path: roles
      ansible_vault_password_file: .ansible_vault_pwd.txt
      ignore_ansible_cfg: true
      require_chef_for_busser: false
    
    verifier:
      root_path: /opt/verifier
    
    platforms:
      - name: alpine
        driver_config:
          image: ironcore864/alpine-busser-serverspec
    
    suites:
      - name: my_suite_a
