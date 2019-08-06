FROM jenkins/jenkins:2.187

COPY --chown=jenkins ./.ssh /var/jenkins_home/.ssh