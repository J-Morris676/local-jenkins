
while ! grep "Jenkins is fully up and running" ~/log > /dev/null;
do
    sleep 1
done

echo "Jenkins is running, applying configurations..."

ADMIN_USERNAME=admin
ADMIN_PASSWORD=$(cat /var/jenkins_home/secrets/initialAdminPassword)
CREDENTIALS_ID="agent_creds"
SLAVE_NAME=ubuntu

echo "Creating '$CREDENTIALS_ID' credentials as $ADMIN_USERNAME:$ADMIN_PASSWORD..."

CRUMB=$(curl --fail --silent --show-error "http://$ADMIN_USERNAME:$ADMIN_PASSWORD@localhost:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,\":\",//crumb)")
curl --fail --silent --show-error -H $CRUMB -X POST "http://$ADMIN_USERNAME:$ADMIN_PASSWORD@localhost:8080/credentials/store/system/domain/_/createCredentials" \
--data-urlencode 'json={
"": "0",
"credentials": {
    "scope": "GLOBAL",
    "id": "agent_creds",
    "username": "jenkins",
    "password": "jenkins",
    "description": "agent creds",
    "$class": "com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl"
}
}'

echo "Creating slave node '$SLAVE_NAME' with '$CREDENTIALS_ID'..."

curl --fail --silent --show-error -H $CRUMB -H "Content-Type:application/x-www-form-urlencoded" -X POST "http://$ADMIN_USERNAME:$ADMIN_PASSWORD@localhost:8080/computer/doCreateItem?name=$SLAVE_NAME&type=hudson.slaves.DumbSlave" \
--data-urlencode 'json={
"": "0",
   "name":"'"$SLAVE_NAME"'",
   "nodeDescription":"",
   "numExecutors":"1",
   "remoteFS":"/home/jenkins",
   "labelString":"ubuntu16",
   "mode":"NORMAL",
   "":[  
      "hudson.plugins.sshslaves.SSHLauncher",
      "hudson.slaves.RetentionStrategy$Always"
   ],
   "launcher":{  
      "stapler-class":"hudson.plugins.sshslaves.SSHLauncher",
      "$class":"hudson.plugins.sshslaves.SSHLauncher",
      "host":"jenkins_agent",
      "credentialsId":"'"$CREDENTIALS_ID"'",
      "":"2",
      "sshHostKeyVerificationStrategy":{  
         "requireInitialManualTrust":false,
         "stapler-class":"hudson.plugins.sshslaves.verifiers.ManuallyTrustedKeyVerificationStrategy",
         "$class":"hudson.plugins.sshslaves.verifiers.ManuallyTrustedKeyVerificationStrategy"
      },
      "port":"22",
      "javaPath":"",
      "jvmOptions":"",
      "prefixStartSlaveCmd":"",
      "suffixStartSlaveCmd":"",
      "launchTimeoutSeconds":"",
      "maxNumRetries":"",
      "retryWaitTime":"",
      "tcpNoDelay":true,
      "workDir":""
   },
   "retentionStrategy":{  
      "stapler-class":"hudson.slaves.RetentionStrategy$Always",
      "$class":"hudson.slaves.RetentionStrategy$Always"
   },
   "nodeProperties":{  
      "stapler-class-bag":"true"
   },
   "type":"hudson.slaves.DumbSlave"
}'
