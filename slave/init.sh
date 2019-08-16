#!/bin/bash
chgrp docker /var/run/docker.sock
/usr/sbin/sshd -D