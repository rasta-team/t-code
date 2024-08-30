#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="rasta-team"
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
if [[ "$IP" = "" ]]; then
domain=$(cat /usr/local/etc/xray/domain)
else
domain=$IP
fi
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
IPVPS=$(curl -s ipinfo.io/ip )
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
swap=$( free -m | awk 'NR==4 {print $2}' )
clear
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# USERNAME
rm -f /usr/bin/user
username=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $2}' )
echo "$username" > /usr/bin/user
# Order ID
rm -f /usr/bin/ver
user=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $3}' )
echo "$user" > /usr/bin/ver
# validity
rm -f /usr/bin/e
valid=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}' )
echo "$valid" > /usr/bin/e
# DETAIL ORDER
username=$(cat /usr/bin/user)
oid=$(cat /usr/bin/ver)
exp=$(cat /usr/bin/e)
# TOTAL ACC CREATE VMESS WS
totalvm=$(grep -c -E "^### " "/usr/local/etc/xray/config.json" )
# TOTAL ACC CREATE  VLESS WS
totalvl=$(grep -c -E "^### " "/usr/local/etc/xray/vless.json")
# TOTAL ACC CREATE  VLESS TCP XTLS
totaltcp=$(grep -c -E "^### " "/usr/local/etc/xray/xtls.json")
# TOTAL ACC CREATE  TROJAN
totaltr=$(grep -c -E "^### " "/usr/local/etc/xray/trojanws.json")
# TOTAL ACC CREATE  TROJAN GO
totalgo=$(grep -c -E "^### " "/etc/trojan-go/akun.conf")
# TOTAL ACC CREATE OVPN SSH
total_ssh="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
red=='\e[0;31m'
#Download/Upload today
dtoday="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
utoday="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
ttoday="$(vnstat -i eth0 | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload yesterday
dyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $2" "substr ($3, 1, 1)}')"
uyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $5" "substr ($6, 1, 1)}')"
tyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload current month
dmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $3" "substr ($4, 1, 1)}')"
umon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $6" "substr ($7, 1, 1)}')"
tmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $9" "substr ($10, 1, 1)}')"
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*/} / ${corediilik:-1}))"
cpu_usage+=" %"
daily_usage=$(vnstat -d --oneline | awk -F\; '{print $6}' | sed 's/ //')
monthly_usage=$(vnstat -m --oneline | awk -F\; '{print $11}' | sed 's/ //')
uram=$(free -m | awk 'NR==2 {print $3}')
fram=$(free -m | awk 'NR==2 {print $4}')
clear

# STATUS EXPIRED ACTIVE
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[4$below" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}(Active)${Font_color_suffix}"
Error="${Green_font_prefix}${Font_color_suffix}${Red_font_prefix}[EXPIRED]${Font_color_suffix}"

today=`date -d "0 days" +"%Y-%m-%d"`
Exp1=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}')
if [[ $today < $Exp1 ]]; then
sts="${Info}"
else
sts="${Error}"
fi
clear
# CERTIFICATE STATUS
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(( (d1 - d2) / 86400 ))
# PROVIDED
creditt=$(cat /root/provided)
# BANNER COLOUR
banner_colour=$(cat /etc/banner)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
# LINE COLOUR
line=$(cat /etc/line)
# TEXT COLOUR ON TOP
text=$(cat /etc/text)
# TEXT COLOUR BELOW
below=$(cat /etc/below)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
# NUMBER COLOUR
number=$(cat /etc/number)
# BANNER
banner=$(cat /usr/bin/bannerku)
ascii=$(cat /usr/bin/test)
clear
echo -e "\e[$banner_colour"
figlet -f $ascii "$banner"
echo -e "\e[$text Premium Script"
echo -e   " \e[$line───────────────────────────────────────────────────\e[m"
echo -e   " \e[$back_text              \e[30m[\e[$box SERVER INFORMATION\e[30m ]\e[1m               \e[m"
echo -e   " \e[$line───────────────────────────────────────────────────\e[m"
echo -e "  \e[$text Cpu Model            :$cname"
echo -e "  \e[$text Number Of Core       : $cores"
echo -e "  \e[$text Cpu Frequency        :$freq MHz"
echo -e "  \e[$text CPU Usage            : $cpu_usage1 %"
echo -e "  \e[$text Used RAM             : $uram MB"
echo -e "  \e[$text Free RAM             : $fram MB"
echo -e "  \e[$text Total Amount Of Ram  : $tram MB"
echo -e "  \e[$text System Uptime        : $uptime"
echo -e "  \e[$text Isp/Provider Name    : $ISP"
echo -e "  \e[$text City Location        : $CITY"
echo -e "  \e[$text Time Location        : $WKT"
echo -e "  \e[$text Ip Vps/Address       : $IPVPS"
echo -e "  \e[$text Domain Name          : $domain\e[0m"
echo -e "  \e[$text Telegram             : @GHReyz"
echo -e "  \e[$text Script Version       : Remode V3"
echo -e "  \e[$text Certificate Status   : Lifetime"
echo -e "  \e[$text Daily Data Usage     :\e[m \e[$below$daily_usage${N}"
echo -e "  \e[$text Monthly Data Usage   :\e[m \e[$below$monthly_usage${N}"
echo -e "  \e[$text Provided By          : $creditt"
echo -e   " \e[$line───────────────────────────────────────────────────\e[m"
echo -e   "  \e[1;32m Traffic\e[0m       \e[0;37mToday     Yesterday      Month   "
echo -e   "  \e[1;32m Download\e[0m      $dtoday    $dyest       $dmon   \e[0m"
echo -e   "  \e[1;32m Upload\e[0m        $utoday    $uyest       $umon   \e[0m"
echo -e   "  \e[1;32m Total\e[0m       \033[0;36m  $ttoday    $tyest       $tmon  \e[0m "
echo -e   " \e[$line───────────────────────────────────────────────────\e[m"
echo -e   " \e[$line      ┌───────────────────────────────────┐\e[m"
echo -e   "                   LIST ACCOUNTS\e                         \e[m"
echo -e  "        ───────────────────────────────────  " | lolcat
echo -e  "           »»  SSH/OVPN   :\e[m \e[$text $total_ssh Account "
echo -e  "           »»  VMESS WS   :\e[m \e[$text $totalvm Account  "  
echo -e  "           »»  VLESS WS   :\e[m \e[$text $totalvl Account "
echo -e  "           »»  VLESS XTLS :\e[m \e[$text $totaltcp Account "
echo -e  "           »»  TROJAN TCP :\e[m \e[$text $totaltr Account "
echo -e  "           »»  TROJAN GO  :\e[m \e[$text $totalgo Account "
echo -e   " \e[$line───────────────────────────────────────────────────\e[m"
echo -e   " \e[$back_text                    \e[30m[\e[$box MAIN MENU\e[30m ]\e[1m                  \e[m"
echo -e   " \e[$line───────────────────────────────────────────────────\e[m"
echo -e   "  \e[$number (•1)\e[m \e[$below Openssh & Openvpn\e[m       \e[$number (•7)\e[m \e[$below MENU Themes\e[m"
echo -e   "  \e[$number (•2)\e[m \e[$below Xray Vmess & Vless\e[m      \e[$number (•8)\e[m \e[$below Clear LOG VPS\e[m"
echo -e   "  \e[$number (•3)\e[m \e[$below Trojan TCP & Grpc Tls\e[m   \e[$number (•9)\e[m \e[$below Change Port\e[m"
echo -e   "  \e[$number (•4)\e[m \e[$below Panel Shadowsocks\e[m       \e[$number (10)\e[m \e[$below Check Running\e[m"
echo -e   "  \e[$number (•5)\e[m \e[$below Panel Wireguard\e[m         \e[$number (11)\e[m \e[$below Traffic XRAY\e[m"
echo -e   "  \e[$number (•6)\e[m \e[$below System MENU\e[m             \e[$number (12)\e[m \e[$below Info ALL Port\e[m"
echo -e   " \e[$line───────────────────────────────────────────────────\e[m"
echo -e   "  \e[$below Premium VPS by $creditt"
echo -e   "  \e[$below Thank you for using this script"
echo -e   " \e[$line───────────────────────────────────────────────────\e[m"
echo -e   ""
echo -e   "  \e[$below [Ctrl + C] For exit from main menu\e[m"
echo -e   "\e[$below "
read -p   "   Select From Options [1-12 or x] :  " menu
echo -e   ""
case $menu in
1)
ssh
;;
2)
xraay
;;
3)
trojaan
;;
4)
ssssr
;;
5)
wgr
;;
6)
system
;;
7)
themes
;;
8)
clear-log
;;
9)
change-port
;;
10)
check-sc
;;
11)
trafficxray
;;
12)
info
;;
x)
clear
exit
echo  -e "\e[1;31mPlease Type menu For More Option, Thank You\e[0m"
;;
*)
clear
echo  -e "\e[1;31mPlease enter an correct number\e[0m"
sleep 1
menu
;;
esac
