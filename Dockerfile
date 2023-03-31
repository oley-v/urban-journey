# Fixed LTS to ensure that works as configured for everyone
FROM ubuntu:20.04
# installing ssh
RUN apt-get update && apt-get install -y openssh-server
# satisfying some directory structure
RUN mkdir /var/run/sshd
# creating non root user
RUN useradd -m -s /bin/bash sshuser
# setting passwords
RUN echo 'sshuser:password1' | chpasswd
RUN echo 'root:password2' | chpasswd
# enabeling root login covering all deb distros cases
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
# ssh keys authN for sshuser it needs to be generated first
#COPY my_ssh_key.pub /home/sshuser/.ssh/authorized_keys
#RUN chown -R sshuser:sshuser /home/sshuser/.ssh
#RUN chmod 600 /home/sshuser/.ssh/authorized_keys
#RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
# limiting max auth to slow down brute force
#RUN sed -i 's/#MaxAuthTries 6/MaxAuthTries 3/' /etc/ssh/sshd_config
# making plugable auth modules working and ssh
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
# exposing ssh on the container
EXPOSE 22
# running sshd as a daemon
CMD ["/usr/sbin/sshd", "-D"]
