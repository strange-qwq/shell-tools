#!/bin/bash
echo -e "\033[32m 欢迎使用 Redhat 8 初始化工具(By.QWQ)，3秒后开始操作！ \033[0m"
sleep 3
echo -e "\033[33m 关闭防火墙 \033[0m"
systemctl stop firewalld.service && systemctl disable firewalld.service
echo -e "\033[33m 关闭 Selinux \033[0m"
sed -i 's#SELINUX=enforcing#SELINUX=disabled#' /etc/selinux/config
echo -e "\033[33m 设置关闭盖子什么都不做 \033[0m"
sed -i 's/#HandleLidSwitch=suspend/HandleLidSwitch=lock/' /etc/systemd/logind.conf
echo -e "\033[33m 设置 root 账户自动登录 \033[0m"
sed -i 's#root:x:0:0#root::0:0#' /etc/passwd && sed -i '5a AutomaticLoginEnable=true\nAutomaticLogin=root' /etc/gdm/custom.conf
# echo -e "\033[33m 删除国内用不了的Redhat yum 源 \033[0m"
# sed -i 's#enabled=1#enabled=0#' /etc/yum/pluginconf.d/subscription-manager.conf
echo -e "\033[33m 切换阿里云 yum 源 \033[0m"
# mv /etc/yum.repos.d/redhat.repo /etc/yum.repos.d/redhat.repo.bak
wget -O /etc/yum.repos.d/redhat.repo http://mirrors.aliyun.com/repo/Centos-8.repo
echo -e "\033[33m 安装 epel yum 源 \033[0m"
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
echo -e "\033[33m 清理及重建 yum 缓存 \033[0m"
yum clean all && yum makecache
echo -e "\033[33m 设置中文 \033[0m"
yum install kde-l10n-Chinese -y && yum reinstall glibc-common -y
dnf install glibc-langpack-zh.x86_64 -y
echo -e "LANG=zh_CN.utf8" > /etc/locale.conf
source /etc/locale.conf
# echo -e "\033[33m 安装 Jdk 1.8 \033[0m"
# yum install java-1.8.0-openjdk java-1.8.0-openjdk-devel -y
# echo -e "\033[33m 安装 Jdk 11 \033[0m"
yum install java-11-openjdk-headless java-11-openjdk java-11-openjdk-devel -y
echo -e "\033[33m 安装 Screen 多命令行管理程序 \033[0m"
yum install screen -y
echo -e "\033[33m 更新系统及软件，此操作耗时较长，请耐心等待，谢谢 \033[0m"
yum update -y
echo -e "\033[32m 初始化完毕，系统将于5秒后自动重启，感谢您的使用，再见！ \033[0m"
sleep 5
echo `rm -rf $0`
reboot