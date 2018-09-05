

for i in {sc-1,sc-2,pl-3,pl-4};do ssh $i dvemon stopall;echo "~~~~~~~~~~~~~$i done~~~~~~~~~~~~";done

for i in {sc-1,sc-2,pl-3};do ssh $i rm -r /var/zookeeper/server/data;echo "~~~~~~~~~~~~~$i done~~~~~~~~~~~~";done

/opt/dve/bin/backupScripts/zookeeperBackup.sh restore /tmp/zookeep*.tar.gz

for i in {sc-1,sc-2,pl-3};do ssh $i ls -alh /var/zookeeper/server/data/*;echo "~~~~~~~~~~~~~$i done~~~~~~~~~~~~";done

for i in {sc-1,sc-2,pl-3,pl-4};do ssh $i dvemon stopall;echo "~~~~~~~~~~~~~$i done~~~~~~~~~~~~";done

for i in {sc-1,sc-2,pl-3,pl-4};do ssh $i dvemon startall;echo "~~~~~~~~~~~~~$i done~~~~~~~~~~~~";done

for i in {sc-1,sc-2,pl-3,pl-4};do ssh $i dvemon restartall;echo "~~~~~~~~~~~~~$i done~~~~~~~~~~~~";done

for i in {sc-1,sc-2,pl-3,pl-4};do ssh $i dvemon enableAllTraffic;echo "~~~~~~~~~~~~~$i done~~~~~~~~~~~~";done

for i in {sc-1,sc-2,pl-3,pl-4};do ssh $i dvemon restartas;echo "~~~~~~~~~~~~~$i done~~~~~~~~~~~~";done
