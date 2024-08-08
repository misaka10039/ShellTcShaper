# ShellTcShaper

本脚本通过tc命令，定时限制linux服务器的指定网卡网速。通常用作pcdn的白天限速。

将本脚本授权，放在crontab里面使用bash运行。
*/5 * * * * /bin/bash /root/ShellTcShaper.sh
