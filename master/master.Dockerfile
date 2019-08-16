FROM jenkins/jenkins:2.187

COPY --chown=jenkins ./.ssh /var/jenkins_home/.ssh
COPY ./*.sh /usr/local/bin/

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

ENTRYPOINT ["/usr/local/bin/init.sh"]