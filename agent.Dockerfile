FROM picoded/ubuntu-openjdk-8-jdk

RUN apt-get update && \
    apt-get -qy full-upgrade && \
    apt-get install -qy git && \
    apt-get install -qy openssh-server && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd && \
    adduser --quiet jenkins && \
    echo "jenkins:jenkins" | chpasswd

RUN apt-get -qy install awscli && \
    apt-get -qy install docker.io && \
    usermod -aG docker jenkins

COPY .ssh/id_rsa.pub /home/jenkins/.ssh/authorized_keys
RUN chown -R jenkins:jenkins /home/jenkins/.ssh/

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
