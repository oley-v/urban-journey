SSHD Configuration Hands-on Demo
================================
An Ubuntu/deb based container with OpenSSH daemon to quickly experiment with sshd.conf in a relatively safe Docker environment. The container is not hardened do not expose it publicly.

TODO: A make file with ssh-keygen and docker commands 

How To
------
Change the config via Dockerfile, re-build, and run. You can practice Docker skills, sed, and sshd_config. 

_Example_
``` bash
ssh-keygen -f ./my_ssh_key
```
``` docker
COPY my_ssh_key.pub /home/sshuser/.ssh/authorized_keys
RUN chown -R sshuser:sshuser /home/sshuser/.ssh
RUN chmod 600 /home/sshuser/.ssh/authorized_keys
```

_Build_ 
``` bash
docker build -t sshd-ubnt .
```

_Run_
``` bash
docker run -d -p2222:22 --name demo-sshd sshd-ubnt
```

_SSH to the Container with the password_
``` bash
ssh root@localhost -p 2222
```

_SSH to the Container with the key_
``` bash
ssh -i ./my_ssh_key sshuser@localhost -p 2222
```


OpenSSH Manual
--------------
[Read The Fantastic Manual: OpenSSH](https://www.openssh.com/manual.html)