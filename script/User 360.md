#User 360

## Request
LDAP FE
CUDB 
mysql
cs/ps

## keyworks
odn
rdn
entrykey
mscid
base64 output

##table
object
rdn
others


## user360 attribute
/cluster/home/asuser/nodes/4/domains/dge-domain/config/sourcetable/configData.xml


## login the CUDB:
SC-2:mysql -uroot -proot -P 15001 -h 10.170.22.245 cudb_user_data
(dsg0:15001    dsg1:15011   dsg2:15021     dsg3:15031)

## login FreshDB:
/opt/mysql/bin/mysql -S /var/data_analytic/mysqld3306.sock


## Support 400G

1.vi /opt/dve-repository/LOTC-CFG/config/disk_preparation.sh
主要的 partition 的代码 都在这里.
parted /dev/md0 mkpart primary ext3 12GB 1012GB
mkfs.ext3 -L DATA_ANALYTICS /dev/md0p3
mkdir -p /var/data_analytic
mount /dev/md0p3 /var/data_analytic
 
2. cluster.conf 文件里面 加
ram-rootfs-size 1 6144
ram-rootfs-size 2 6144
 
cluster config -r -a
 
3. mount ISO
 Copy mnt 目录 修改 所有的 有checkEnv 方法的地方