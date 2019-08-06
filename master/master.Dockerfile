FROM jenkins/jenkins:2.187

COPY --chown=jenkins ./.ssh /var/jenkins_home/.ssh
COPY ./*.sh /usr/local/bin/

RUN install-plugins.sh credentials ssh-slaves

ENTRYPOINT ["/usr/local/bin/init.sh"]