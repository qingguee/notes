## ps package 
procps

## Sed

sed -i "s/%{PRODUCT_NUMBER}/$pno/" system.yml

# Remove com.oam.access.aggregation.template, as it is tmplate only. 
# If not, csmlint will have errors. 
sed -i '/- uid: com.oam.access.aggregation.template/^$/d' $CSM_WORKSPACE/csm.yml
sed -e '/- uid: com.oam.access.aggregation.template/monitor-period: 20 s/d' CSM_WORKSPACE/csm.yml


sed -i "s/%{AMcash}/$ESM_AMcash/" ./ArtifactManager.cfg


## IF

 shell中if做比较

shell判断数组中是否包含某个元素：

ary=(1 2 3)

a=2

if [[ "${ary[@]}" =~ "$a" ]] ; then
    echo "a in ary"
else
    echo "a not in ary"
fi

判读字符串($str)是否包含另一个字符串($str1)：

方法1：

if [  `echo $str | grep -e '$str1'`  ] ; then

    echo yes

fi

方法2(如果$str1在判断中直接使用字符串而不是变量，则不能加引号，如if [[ $str =~ ^dx ]]判读字符串$str是否以dx开头，^dx不能加引号)：

if [[ $str =~ $str1 ]] ; then

    echo yes

fi

 

比较两个字符串是否相等的办法是：

    if [ "$test"x = "test"x ]; then

    这里的关键有几点：

    1 使用单个等号

    2 注意到等号两边各有一个空格：这是unix shell的要求

    3 注意到"$test"x最后的x，这是特意安排的，因为当$test为空的时候，上面的表达式就变成了x = testx，显然是不相等的。而如果没有这个x，表达式就会报错：[: =: unary operator expected

    

    二元比较操作符,比较变量或者比较数字.注意数字与字符串的区别.

    整数比较

    -eq 等于,如:if [ "$a" -eq "$b" ]

    -ne 不等于,如:if [ "$a" -ne "$b" ]

    -gt 大于,如:if [ "$a" -gt "$b" ]

    -ge 大于等于,如:if [ "$a" -ge "$b" ]

    -lt 小于,如:if [ "$a" -lt "$b" ]

    -le 小于等于,如:if [ "$a" -le "$b" ]

     大于(需要双括号),如:(("$a" > "$b"))

    >= 大于等于(需要双括号),如:(("$a" >= "$b"))

    小数据比较可使用AWK

    字符串比较

    = 等于,如:if [ "$a" = "$b" ]

    == 等于,如:if [ "$a" == "$b" ],与=等价

     注意:==的功能在[[]]和[]中的行为是不同的,如下:

     1 [[ $a == z* ]] # 如果$a以"z"开头(模式匹配)那么将为true

     2 [[ $a == "z*" ]] # 如果$a等于z*(字符匹配),那么结果为true

     3

     4 [ $a == z* ] # File globbing 和word splitting将会发生

     5 [ "$a" == "z*" ] # 如果$a等于z*(字符匹配),那么结果为true

     一点解释,关于File globbing是一种关于文件的速记法,比如"*.c"就是,再如~也是.

     但是file globbing并不是严格的正则表达式,虽然绝大多数情况下结构比较像.

    != 不等于,如:if [ "$a" != "$b" ]

     这个操作符将在[[]]结构中使用模式匹配.

     大于,在ASCII字母顺序下.如:

     if [[ "$a" > "$b" ]]

     if [ "$a" \> "$b" ]

     注意:在[]结构中">"需要被转义.

     具体参考Example 26-11来查看这个操作符应用的例子.

    -z 字符串为"null".就是长度为0.

    -n 字符串不为"null"

     注意:

     使用-n在[]结构中测试必须要用""把变量引起来.使用一个未被""的字符串来使用! -z

     或者就是未用""引用的字符串本身,放到[]结构中。虽然一般情况下可

     以工作,但这是不安全的.习惯于使用""来测试字符串是一种好习惯.

if判断式
if [ 条件判断一 ] && (||) [ 条件判断二 ]; then
elif [ 条件判断三 ] && (||) [ 条件判断四 ]; then
else
   执行第三段內容程式
fi

例如：

 

root@Bizbox:~# a=0
root@Bizbox:~# b=0
root@Bizbox:~# c=5         
root@Bizbox:~# if [ $a = 0 -a $b = 0 ]&&[ $c != 0 ]; then
> echo success
> fi
success

if 使用的表达式
Primary 意义
[ -a 文件 ] 如果文件存在为真。
[ -b 文件 ] 如果 文件 存在 而且 是一个 块-特殊 文件为真。
[ -c 文件 ] 为真 如果 文件 存在 而且 是一个 字-特殊 文件。

 
[ -d 文件 ] 为真 如果 文件 存在 而且 是一个 目录。
[ -e 文件 ] 为真 如果 文件 存在。
[ -f 文件 ] 为真 如果 文件 存在 而且 是一个 普通 文件。
[ -g 文件 ] 为真 如果 文件 存在 而且 已经设置了他的 SGID 位。
[ -h 文件 ] 为真 如果 文件 存在 而且 是一个 符号连接。
[ -k 文件 ] 为真 如果 文件 存在 而且 他的粘住位已经设置。
[ -p 文件 ] 为真 如果 文件 存在 而且 是一个 已经命名的管道 (F 如果O)。
[ -r 文件 ] 为真 如果 文件 存在 而且 是可读的。
[ -s 文件 ] 为真 如果 文件 存在 而且 比零字节大。
[ -t FD ] 为真 如果 文件 文件描述符已经打开 而且 指向一个终端。
[ -u 文件 ] 为真 如果 文件 存在 而且 已经设置了他的 SUID (set user ID)位。
[ -w 文件 ] 为真 如果 文件 为真 如果 文件 存在 而且 是可写的。
[ -x 文件 ] 为真 如果 文件 存在 而且 是可执行的。
[ -O 文件 ] 为真 如果 文件 存在 而且 属于有效用户ID。
[ -G 文件 ] 为真 如果 文件 存在 而且 属于有效组ID。
[ -L 文件 ] 为真 如果 文件 存在 而且 是一个 符号连接。
[ -N 文件 ] 为真 如果 文件 存在 而且 has been mod 如果ied since it was last read。
[ -S 文件 ] 为真 如果 文件 存在 而且 是一个 socket。
[ 文件1 -nt 文件2 ] 为真 如果 文件1 has been changed more recently than 文件2, or 如果
文件1 存在 而且
文件2 does not。
[ 文件1 -ot 文件2 ] 为真 如果 文件1 比 文件2 旧, 或者 文件2 存在而且 文件1 不存在。
[ 文件1 -ef 文件2 ] 为真 如果 文件1 而且 文件2 refer to the same device 而且 inode
numbers。
[ -o 选项名 ] 为真 如果 shell 选项 "选项名" 开启。
[ -z STRING ] 为真 如果 "STRING"的长度是零。
[ -n STRING ] 或者 [ STRING ] 为真 "STRING"的长度是非零值。
[ STRING1 == STRING2 ] 如果两个字符串相等为真。 "=" may be used instead of "==" for
strict POSIX compliance。
[ STRING1 != STRING2 ] 为真 如果 两两个字符串不相等。
[ STRING1 < STRING2 ] 为真 如果 "STRING1" sorts before "STRING2" lexicographically in the
current locale。
[ STRING1 > STRING2 ] 为真 如果 "STRING1" sorts after "STRING2" lexicographically in the
current locale。
[ ARG1 OP ARG2 ]
"OP" 是 -eq, -ne, -lt, -le, -gt or -ge 其中一个。 These arithmetic binary operators
return 为真 如果 "ARG1" is equal to, not equal to, less than, less than or equal to, greater
than, or greater than or equal to "ARG2", respectively。 "ARG1" 而且 "ARG2" are
integers。
表达式可以借以下操作符组合起来, listed in decreasing order of precedence:
操作符效果
[ ! EXPR ] 如果EXPR 为假则为真。
[ ( EXPR ) ] 返回EXPR 的值。 这样可以用来忽略正常的操作符优先级。

 
[ 表达式1 -a 表达式2 ] 如果表达式1 而且表达式2 同时为真则为真 。
[ 表达式1 -o 表达式2 ] 如果表达式1 或者表达式2 其中之一为真则为真。
==========================================



### netstat

- 获取进程名、进程号以及用户 ID
sudo netstat -nlpt
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 127.0.1.1:53            0.0.0.0:*               LISTEN      1144/dnsmasq    
tcp        0      0 127.0.0.1:631           0.0.0.0:*               LISTEN      661/cupsd       
tcp6       0      0 ::1:631                 :::*                    LISTEN      661/cupsd

相比进程名和进程号而言，查看进程的拥有者会更有用。使用 -ep 选项可以同时查看进程名和用户名。
$ sudo netstat -ltpe
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       User       Inode       PID/Program name
tcp        0      0 enlightened:domain      *:*                     LISTEN      root       11090       1144/dnsmasq    
tcp        0      0 localhost:ipp           *:*                     LISTEN      root       9755        661/cupsd       
tcp6       0      0 ip6-localhost:ipp       [::]:*                  LISTEN      root       9754        661/cupsd



systemctl enable kube-apiserver.service
systemctl start kube-apiserver.service
systemctl enable kube-controller-manager.service
systemctl start kube-controller-manager.service
systemctl enable kube-scheduler.service
systemctl start kube-scheduler.service


systemctl enable kubelet.service
systemctl start kubelet.service
systemctl enable kube-proxy.service
systemctl start kube-proxy.service