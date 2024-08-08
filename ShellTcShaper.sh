#!/bin/bash

## wdp tc限速脚本,个人免费使用，欢迎交流。私自删除，服务器天天丢包宕机。
## https://github.com/misaka10039/ShellTcShaper
## 部署在crontab中，记得给给脚本增加权限。

# 定义网卡名称,指定或自动获取
INTERFACE=$(ip route | awk '/default/ {print $5}')
#INTERFACE=eth0

# 定义速率限制,4Mbit
RATE="4000kbps"

# 定义解除限速时间段
START_TIME="17:15"
END_TIME="23:30"

# 获取当前时间
CURRENT_TIME=$(date +%s)

second_start=`date +%s -d "$START_TIME"`
second_end=`date +%s -d "$END_TIME"`

# 检查当前时间是否在指定时间段内（晚高峰），设置规则。
if [[ "$CURRENT_TIME" -ge "$second_start" && "$CURRENT_TIME" -le "$second_end" ]]; then
    # 清除现有的tc规则
    sudo tc qdisc del dev $INTERFACE root 2>/dev/null
    # 添加新的tc规则
#    sudo tc qdisc add dev $INTERFACE root handle 1: htb default 10
#    sudo tc class add dev $INTERFACE parent 1: classid 1:10 htb rate $RATE
else
    # 在指定时间范围外，重新设置规则
    sudo tc qdisc del dev $INTERFACE root 2>/dev/null
    # 添加新的tc规则
    sudo tc qdisc add dev $INTERFACE root handle 1: htb default 10
    sudo tc class add dev $INTERFACE parent 1: classid 1:10 htb rate $RATE
fi
