FROM picoded/ubuntu-openjdk-8-jdk

# Configure OpenSsh Server
RUN apt-get update && \
    apt-get -qy full-upgrade && \
    apt-get install -qy git && \
    apt-get install -qy openssh-server && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd && \
    adduser --quiet jenkins && \
    echo "jenkins:jenkins" | chpasswd

# Install AWS CLI
USER jenkins
ENV PATH="/home/jenkins/.local/bin:${PATH}"
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py --user && \
    echo 'PATH="~/jenkins/.local/bin:$PATH"' >> ~/.bash_profile && \
    pip install awscli --upgrade --user
USER root

# Install Docker
RUN apt-get -qy install docker.io && \
    usermod -aG docker jenkins

COPY .ssh/id_rsa.pub /home/jenkins/.ssh/authorized_keys
COPY ./*.sh /usr/local/bin/
RUN chown -R jenkins:jenkins /home/jenkins/.ssh/

EXPOSE 22
ENTRYPOINT ["/usr/local/bin/init.sh"]
