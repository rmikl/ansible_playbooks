#!/bin/bash 

if [[ ! -f /data/gerrit/bin/gerrit.sh ]]; then 
    export GERRIT_SITE="/data/gerrit/"
    wget --no-check-certificate https://gerrit-releases.storage.googleapis.com/gerrit-3.3.1.war -P /data/ 
    java -jar /data/gerrit*.war init --batch -d /data/gerrit --dev
fi
 
/etc/init.d/nginx start
/data/gerrit/bin/gerrit.sh run
tail -f /dev/null