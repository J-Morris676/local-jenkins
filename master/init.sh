#!/bin/bash

# Apply configurations when ready
/usr/local/bin/configure-master.sh | sed "s/^/[MASTER_CONFIGURATION]: /" & 
# Run Jenkins
/sbin/tini -- /usr/local/bin/jenkins.sh 2>&1 | tee ~/log
