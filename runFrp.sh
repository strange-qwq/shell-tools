#!/bin/bash
echo `date '+%Y-%m-%d %H:%M:%S'` >> /home/frp.log
network=`iw dev | grep "Interface" | awk '{print $2}'`
if [ "${network}" != "" ];then
    statistics=0
    result=`iw ${network} link | grep "Not connected"`
    while [ "${result}" != "" ]
    do
        if [ ${statistics} > 5 ];then
            break
        fi
        echo 'The ${statistics} times Start !\n==========\n     WiFi     \n==========\n' >> /home/frp.log
        echo `iw ${network} link` >>  /home/frp.log
        sleep 3
        ip link set ${network} up
        let statistics++
        result=`iw ${network} link | grep "Not connected"`
    done
    echo '\n==========\n     Frp     \n==========' >>  /home/frp.log
	cd /home/frp_0.30.0_linux_amd64
    ./frpc -c frpc.ini >> /home/frp.log
fi
