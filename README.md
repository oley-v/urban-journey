SSHD Configuration Hands-on Demo
================================
An Ubuntu/deb based container with OpenSSH daemon to quickly experiment with sshd_config (aka sshd.conf) in a relatively safe Docker environment. 
__WARNING:__ The container is not hardened and clear text passwords are in the Dockerfile do not expose it to public networks.

__TODO:__ A make file with ssh-keygen and docker commands 

How To
------
Change the config via Dockerfile, re-build, and run. You can practice Docker skills, sed, and sshd_config. 

__Example__
To utilize public key ssh auth generate the key
``` Shell
ssh-keygen -f ./my_ssh_key
```
Uncoment the following in the Dockerfile
``` Dockerfile
COPY my_ssh_key.pub /home/sshuser/.ssh/authorized_keys
RUN chown -R sshuser:sshuser /home/sshuser/.ssh
RUN chmod 600 /home/sshuser/.ssh/authorized_keys
```

__Build__
Every time something is changed in the Dockerfile you need to rebuild the container.
``` Shell
docker build -t sshd-ubnt .
```

__Run__
``` Shell
docker run -d -p2222:22 --name sshd-demo sshd-ubnt
```
If Docker complains that the container with the same name already exists
``` Shell
docker container rm sshd-demo
```

__SSH to the Container with the password__
``` Shell
ssh root@localhost -p 2222
```

__SSH to the Container with the key__
``` Shell
ssh -i ./my_ssh_key sshuser@localhost -p 2222
```


OpenSSH Manual
--------------
[Read The Fantastic Manual: OpenSSH](https://www.openssh.com/manual.html)
