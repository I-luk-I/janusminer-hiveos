####################################################################################
###
### janusminer
###
### Hive integration: dmp
###
####################################################################################

if [ "$#" -ne "1" ]
  then
    echo "No arguments supplied. Call using build.sh <VERSION_NUMBER>"
    exit
fi

./createmanifest.sh $1
mkdir janusminer
cp h-manifest.conf h-*.sh wart-miner janusminer
tar czvf janusminer-$1.tgz janusminer
