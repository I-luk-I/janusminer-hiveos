####################################################################################
###
### janusminer
###
### Hive integration: dmp
###
####################################################################################

#!/usr/bin/env bash
[[ -e /hive/miners/custom ]] && . /hive/miners/custom/janusminer/h-manifest.conf
[[ -e /hive/miners/custom ]] && . /hive/miners/custom/janusminer/h-manifest.conf
conf=""
conf+="-h $CUSTOM_URL -a $CUSTOM_TEMPLATE"

[[ ! -z $CUSTOM_USER_CONFIG ]] && conf+=" $CUSTOM_USER_CONFIG"

echo "$conf"
echo "$conf" > $CUSTOM_CONFIG_FILENAME

