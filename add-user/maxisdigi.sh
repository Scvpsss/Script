#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
colornow=$(cat /etc/tarap/theme/color.conf)
export NC="\e[0m"
export YELLOW='\033[0;33m';
export RED="\033[0;31m"
export COLOR1="$(cat /etc/tarap/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
export COLBG1="$(cat /etc/tarap/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
WH='\033[1;37m'
###########- END COLOR CODE -##########

BURIQ () {
    curl -sS https://raw.githubusercontent.com/Scvpsss/izin/main/vps > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/Scvpsss/izin/main/vps | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/Scvpsss/izin/main/vps | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}
red='\e[1;31m'
green='\e[1;32m'
yellow='\033[0;33m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
echo -ne
else
red "Permission Denied!"
exit 0
fi
clear
echo -e "\e[32mloading...\e[0m"
clear
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
# TOTAL ACC CREATE VMESS WS
total1=$(grep -c -E "^#vms " "/usr/local/etc/xray/vmess.json")
# TOTAL ACC CREATE  VLESS WS
total2=$(grep -c -E "^#vls " "/usr/local/etc/xray/vless.json")
# TOTAL ACC CREATE  TROJAN WS TLS
total3=$(grep -c -E "^#trws " "/usr/local/etc/xray/trojan.json")
MYIP=$(wget -qO- ifconfig.me/ip);
source /var/lib/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /usr/local/etc/xray/domain)
else
domain=$IP
fi

# FUCTION ADD USER
function menu1 () {
clear
tls="$(cat ~/log-install.txt | grep -w "Vmess Ws Tls" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess Ws None Tls" | cut -d: -f2|sed 's/ //g')"
echo -e "\e[$line══════════════════════════════════════════════════════════════════${NC}"
echo -e "\e[$back_text                         \e[30m[\e[$box XRAY VMESS WS\e[30m]                         \e[m"
echo -e "\e[$line══════════════════════════════════════════════════════════════════${NC}"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "   Username: " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/vmess.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
read -p "   Masukan (uuid) : " uuid
#patchtls=/vmesswstls
#patchnontls=/vmesswsntls
#uuid=$(cat /proc/sys/kernel/random/uuid)
#read -p "   Bug Address (Example: www.google.com) : " address
#read -p "   Bug SNI/Host (Example : m.facebook.com) : " sni
read -p "   Expired (days) : " masaaktif
bug_addr=${address}.
bug_addr2=$address
if [[ $address == "" ]]; then
sts=$bug_addr2
else
sts=$bug_addr
fi
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
harini=`date -d "0 days" +"%Y-%m-%d"`
sed -i '/#xray-vmess-tls$/a\#vms '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/vmess.json
sed -i '/#xray-vmess-nontls$/a\#vms '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/vmessnone.json
cat>/usr/local/etc/xray/$user-tls.json<<EOF
       {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "$uuid",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "${sni}",
      "tls": "tls"
}
EOF
cat>/usr/local/etc/xray/$user-celcom.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "www.speedtest.net",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchnontls",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF
cat>/usr/local/etc/xray/$user-none.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "$uuid",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "${sni}",
      "tls": "none"
}
EOF
cat>/usr/local/etc/xray/$user-digi.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "162.159.134.61",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchnontls",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)
vmess_base644=$( base64 -w 0 <<< $vmess_json4)
vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)"
vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-celcom.json)"
vmesslink3="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)"
vmesslink4="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-digi.json)"
systemctl restart xray@vmess
systemctl restart xray@vmessnone
service cron restart
clear
echo -e ""
echo -e "\e[$line══════════════════════════════════════════════════════════════════${NC}"
echo -e "\e[$back_text                         \e[30m[\e[$box XRAY VMESS WS\e[30m]                         \e[m"
echo -e "\e[$line══════════════════════════════════════════════════════════════════${NC}"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : $MYIP"
echo -e "Port TLS       : ${tls}"
echo -e "Port None TLS  : ${none}"
echo -e "User ID        : ${uuid}"
echo -e "Security       : Auto"
echo -e "Network        : Websocket"
echo -e "Path Tls       : $patchtls"
echo -e "Path None Tls  : $patchnontls"
echo -e "allowInsecure  : True/allow"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Maxis)   : ${vmesslink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Celcom)  : ${vmesslink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Yes)     : ${vmesslink3}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Digi)    : ${vmesslink4}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created   :$harini"
echo -e "Expired   :$exp"
echo -e "Script By $creditt"
echo ""
read -n 1 -s -r -p "Press any key to back on menu maxisdigi"
maxisdigi
}
# TRIAL USER
function menu2 () {
clear
tls="$(cat ~/log-install.txt | grep -w "Vmess Ws Tls" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess Ws None Tls" | cut -d: -f2|sed 's/ //g')"
echo -e " ${Lred}══════════════════════════════════════════════════════════════════${NC}"
echo -e " ${BGWHITE}                     [ TRIAL XRAY VMESS WS ]                      ${NC}"
echo -e " ${Lred}══════════════════════════════════════════════════════════════════${NC}"
# Create Expried 
masaaktif="1"
exp=$(date -d "$masaaktif days" +"%Y-%m-%d")

# Make Random Username 
user=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`

patchtls=/trickers-vmesswstls
patchnontls=/trickers-vmesswsntls
uuid=$(cat /proc/sys/kernel/random/uuid)
#read -p "   Bug Address (Example: www.google.com) : " address
#read -p "   Bug SNI/Host (Example : m.facebook.com) : " sni
bug_addr=${address}.
bug_addr2=$address
if [[ $address == "" ]]; then
sts=$bug_addr2
else
sts=$bug_addr
fi
harini=`date -d "0 days" +"%Y-%m-%d"`
sed -i '/#xray-vmess-tls$/a\#vms '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/vmess.json
sed -i '/#xray-vmess-nontls$/a\#vms '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/vmessnone.json
cat>/usr/local/etc/xray/$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "cdn-dev.hotlink.com.my",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchtls",
      "type": "none",
      "host": "${domain}",
      "tls": "tls",
	  "sni": "cdn-dev.hotlink.com.my"
}
EOF
cat>/usr/local/etc/xray/$user-celcom.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "www.speedtest.net",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchnontls",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF
cat>/usr/local/etc/xray/$user-none.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "cdn.who.int",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchnontls",
      "type": "none",
      "host": "cdn.who.int.${domain}",
      "tls": "none"
}
EOF
cat>/usr/local/etc/xray/$user-digi.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "162.159.134.61",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchnontls",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)
vmess_base644=$( base64 -w 0 <<< $vmess_json4)
vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)"
vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-celcom.json)"
vmesslink3="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)"
vmesslink4="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-digi.json)"
systemctl restart xray@vmess
systemctl restart xray@vmessnone
service cron restart
clear
echo -e ""
echo -e " ${Lred}══════════════════════════════════════════════════════════════════${NC}"
echo -e " ${BGWHITE}                     [ TRIAL XRAY VMESS WS ]                      ${NC}"
echo -e " ${Lred}══════════════════════════════════════════════════════════════════${NC}"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : $MYIP"
echo -e "Port TLS       : ${tls}"
echo -e "Port None TLS  : ${none}"
echo -e "User ID        : ${uuid}"
echo -e "Security       : Auto"
echo -e "Network        : Websocket"
echo -e "Path Tls       : $patchtls"
echo -e "Path None Tls  : $patchnontls"
echo -e "allowInsecure  : True/allow"
echo -e "Support Yaml   : YES"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Pantang Larang $creditt Shop"
echo -e "‼️Aktiviti Berikut Adalah Dilarang(ID akan di ban tanpa notis & tiada refund)"
echo -e "\e[31m❌ Torrent (p2p, streaming p2p)"
echo -e "\e[31m❌ PS4"
echo -e "\e[31m❌ Porn"
echo -e "\e[31m❌ Spam Bug"
echo -e "\e[31m❌ Ddos Server"
echo -e "\e[31m❌ Mining Bitcoins"
echo -e "\e[31m❌ Abuse Usage"
echo -e "\e[31m❌ Multi-Login ID"
echo -e "\e[31m❌ Sharing Premium Config\e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Maxis)   : ${vmesslink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Celcom)  : ${vmesslink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Yes)     : ${vmesslink3}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Digi)    : ${vmesslink4}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created   :$harini"
echo -e "Expired   :$exp"
echo -e "Script By $creditt"
echo ""
read -n 1 -s -r -p "Press any key to back on menu maxisdigi"
maxisdigi
}
# show user
function menu3 () {
clear
tls="$(cat ~/log-install.txt | grep -w "Vmess Ws Tls" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess Ws None Tls" | cut -d: -f2|sed 's/ //g')"
NUMBER_OF_CLIENTS=$(grep -c -E "^#vms " "/usr/local/etc/xray/vmess.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "SHOW USER XRAY VMESS WS"
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
patchtls=/trickers-vmesswstls
patchnontls=/trickers-vmesswsntls
user=$(grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
harini=$(grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
cat>/usr/local/etc/xray/$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "cdn-dev.hotlink.com.my",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchtls",
      "type": "none",
      "host": "${domain}",
      "tls": "tls",
	  "sni": "cdn-dev.hotlink.com.my"
}
EOF
cat>/usr/local/etc/xray/$user-celcom.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "www.speedtest.net",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchnontls",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF
cat>/usr/local/etc/xray/$user-none.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "cdn.who.int",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchnontls",
      "type": "none",
      "host": "cdn.who.int.${domain}",
      "tls": "none"
}
EOF
cat>/usr/local/etc/xray/$user-digi.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "162.159.134.61",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchnontls",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)
vmess_base644=$( base64 -w 0 <<< $vmess_json4)
vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)"
vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-celcom.json)"
vmesslink3="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)"
vmesslink4="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-digi.json)"
clear
echo -e ""
echo -e "\e[$line══════════════════════════════════════════════════════════════════${NC}"
echo -e "\e[$back_text                         \e[30m[\e[$box XRAY VMESS WS\e[30m]                         \e[m"
echo -e "\e[$line══════════════════════════════════════════════════════════════════${NC}"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : $MYIP"
echo -e "Port TLS       : ${tls}"
echo -e "Port None TLS  : ${none}"
echo -e "User ID        : ${uuid}"
echo -e "Security       : Auto"
echo -e "Network        : Websocket"
echo -e "Path Tls       : $patchtls"
echo -e "Path None Tls  : $patchnontls"
echo -e "allowInsecure  : True/allow"
echo -e "Support Yaml   : YES"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Pantang Larang $creditt Shop"
echo -e "‼️Aktiviti Berikut Adalah Dilarang(ID akan di ban tanpa notis & tiada refund)"
echo -e "\e[31m❌ Torrent (p2p, streaming p2p)"
echo -e "\e[31m❌ PS4"
echo -e "\e[31m❌ Porn"
echo -e "\e[31m❌ Spam Bug"
echo -e "\e[31m❌ Ddos Server"
echo -e "\e[31m❌ Mining Bitcoins"
echo -e "\e[31m❌ Abuse Usage"
echo -e "\e[31m❌ Multi-Login ID"
echo -e "\e[31m❌ Sharing Premium Config\e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Maxis)   : ${vmesslink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Celcom)  : ${vmesslink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Yes)     : ${vmesslink3}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Digi)    : ${vmesslink4}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created   :$harini"
echo -e "Expired   :$exp"
echo -e "Script By $creditt"
echo ""
read -n 1 -s -r -p "Press any key to back on menu maxisdigi"
maxisdigi
}
# ADD USER VLESS WS
function menu4 () {
clear
tls="$(cat ~/log-install.txt | grep -w "Vless Ws Tls" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless Ws None Tls" | cut -d: -f2|sed 's/ //g')"
echo -e " ${Lred}══════════════════════════════════════════════════════════════════${NC}"
echo -e " ${BGWHITE}                     [ XRAY VLESS WS ]                            ${NC}"
echo -e " ${Lred}══════════════════════════════════════════════════════════════════${NC}"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "   Username: " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/vless.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
patchtls=/trickers-vlesswstls
patchnontls=/trickers-vlesswsntls
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "   Bug Address (Example: www.google.com) : " address
read -p "   Bug SNI/Host (Example : m.facebook.com) : " sni
read -p "   Expired (days) : " masaaktif
bug_addr=${address}.
bug_addr2=$address
if [[ $address == "" ]]; then
sts=$bug_addr2
else
sts=$bug_addr
fi
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
harini=`date -d "0 days" +"%Y-%m-%d"`
sed -i '/#xray-vless-tls$/a\#vls '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vless.json
sed -i '/#xray-vless-nontls$/a\#vls '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vlessnone.json
vlesslink1="vless://${uuid}@cdn-dev.hotlink.com.my:$tls?path=$patchtls&security=tls&encryption=none&type=ws&host=${sts}${domain}&sni=cdn-dev.hotlink.com.my#${user}"
vlesslink2="vless://${uuid}@www.speedtest.net:$none?path=$patchnontls&encryption=none&type=ws&host=${domain}#${user}"
vlesslink3="vless://${uuid}@cdn.who.int:$none?path=$patchnontls&encryption=none&type=ws&host=cdn.who.int.${domain}#${user}"
vlesslink4="vless://${uuid}@162.159.134.61:$none?path=$patchnontls&encryption=none&type=ws&host=${sts}${domain}#${user}"
vlesslink5="vless://${uuid}@${sts}${domain}:$none?path=$patchnontls&encryption=none&type=ws&host=maingame.com.my#${user}"
systemctl restart xray@vless
systemctl restart xray@vlessnone
clear
echo -e ""
echo -e " ${Lred}══════════════════════════════════════════════════════════════════${NC}"
echo -e " ${BGWHITE}                     [ XRAY VLESS WS ]                            ${NC}"
echo -e " ${Lred}══════════════════════════════════════════════════════════════════${NC}"
echo -e "Remarks          : ${user}"
echo -e "Domain           : ${domain}"
echo -e "IP/Host          : $MYIP"
echo -e "Port TLS         : $tls"
echo -e "Port None TLS    : $none"
echo -e "User ID          : ${uuid}"
echo -e "Encryption       : None"
echo -e "Network          : WebSocket"
echo -e "Path Tls         : $patchtls"
echo -e "Path None Tls    : $patchnontls"
echo -e "allowInsecure    : True/allow"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Pantang Larang $creditt Shop"
echo -e "‼️Aktiviti Berikut Adalah Dilarang(ID akan di ban tanpa notis & tiada refund)"
echo -e "\e[31m❌ Torrent (p2p, streaming p2p)"
echo -e "\e[31m❌ PS4"
echo -e "\e[31m❌ Porn"
echo -e "\e[31m❌ Spam Bug"
echo -e "\e[31m❌ Ddos Server"
echo -e "\e[31m❌ Mining Bitcoins"
echo -e "\e[31m❌ Abuse Usage"
echo -e "\e[31m❌ Multi-Login ID"
echo -e "\e[31m❌ Sharing Premium Config\e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Maxis         : ${vlesslink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Celcom        : ${vlesslink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Yes           : ${vlesslink3}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Digi          : ${vlesslink4}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Umobile       : ${vlesslink5}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created   :$harini"
echo -e "Expired   :$exp"
echo -e "Script By $creditt"
echo ""
read -n 1 -s -r -p "Press any key to back on menu maxisdigi"
maxisdigi
}
# TRIAL USER VLESS WS
function menu5 () {
clear
tls="$(cat ~/log-install.txt | grep -w "Vless Ws Tls" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless Ws None Tls" | cut -d: -f2|sed 's/ //g')"
echo -e " ${Lred}══════════════════════════════════════════════════════════════════${NC}"
echo -e " ${BGWHITE}                     [ TRIAL XRAY VLESS WS ]                      ${NC}"
echo -e " ${Lred}══════════════════════════════════════════════════════════════════${NC}"
# Create Expried 
masaaktif="1"
exp=$(date -d "$masaaktif days" +"%Y-%m-%d")

# Make Random Username 
user=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`

patchtls=/trickers-vlesswstls
patchnontls=/trickers-vlesswsntls
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "   Bug Address (Example: www.google.com) : " address
read -p "   Bug SNI/Host (Example : m.facebook.com) : " sni
bug_addr=${address}.
bug_addr2=$address
if [[ $address == "" ]]; then
sts=$bug_addr2
else
sts=$bug_addr
fi
harini=`date -d "0 days" +"%Y-%m-%d"`
sed -i '/#xray-vless-tls$/a\#vls '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vless.json
sed -i '/#xray-vless-nontls$/a\#vls '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vlessnone.json
vlesslink1="vless://${uuid}@cdn-dev.hotlink.com.my:$tls?path=$patchtls&security=tls&encryption=none&type=ws&host=${sts}${domain}&sni=cdn-dev.hotlink.com.my#${user}"
vlesslink2="vless://${uuid}@www.speedtest.net:$none?path=$patchnontls&encryption=none&type=ws&host=${domain}#${user}"
vlesslink3="vless://${uuid}@cdn.who.int:$none?path=$patchnontls&encryption=none&type=ws&host=cdn.who.int.${domain}#${user}"
vlesslink4="vless://${uuid}@162.159.134.61:$none?path=$patchnontls&encryption=none&type=ws&host=${sts}${domain}#${user}"
vlesslink5="vless://${uuid}@${sts}${domain}:$none?path=$patchnontls&encryption=none&type=ws&host=maingame.com.my#${user}"
systemctl restart xray@vless
systemctl restart xray@vlessnone
clear
echo -e ""
echo -e " ${Lred}══════════════════════════════════════════════════════════════════${NC}"
echo -e " ${BGWHITE}                     [ TRIAL XRAY VLESS WS ]                      ${NC}"
echo -e " ${Lred}══════════════════════════════════════════════════════════════════${NC}"
echo -e "Remarks          : ${user}"
echo -e "Domain           : ${domain}"
echo -e "IP/Host          : $MYIP"
echo -e "Port TLS         : $tls"
echo -e "Port None TLS    : $none"
echo -e "User ID          : ${uuid}"
echo -e "Encryption       : None"
echo -e "Network          : WebSocket"
echo -e "Path Tls         : $patchtls"
echo -e "Path None Tls    : $patchnontls"
echo -e "allowInsecure    : True/allow"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Pantang Larang $creditt Shop"
echo -e "‼️Aktiviti Berikut Adalah Dilarang(ID akan di ban tanpa notis & tiada refund)"
echo -e "\e[31m❌ Torrent (p2p, streaming p2p)"
echo -e "\e[31m❌ PS4"
echo -e "\e[31m❌ Porn"
echo -e "\e[31m❌ Spam Bug"
echo -e "\e[31m❌ Ddos Server"
echo -e "\e[31m❌ Mining Bitcoins"
echo -e "\e[31m❌ Abuse Usage"
echo -e "\e[31m❌ Multi-Login ID"
echo -e "\e[31m❌ Sharing Premium Config\e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Maxis         : ${vlesslink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Celcom        : ${vlesslink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Yes           : ${vlesslink3}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Digi          : ${vlesslink4}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Umobile       : ${vlesslink5}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Umobile       : ${vlesslink5}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created   :$harini"
echo -e "Expired   :$exp"
echo -e "Script By $creditt"
echo ""
read -n 1 -s -r -p "Press any key to back on menu maxisdigi"
maxisdigi
}
# show user vless ws
function menu6 () {
clear
tls="$(cat ~/log-install.txt | grep -w "Vless Ws Tls" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless Ws None Tls" | cut -d: -f2|sed 's/ //g')"
NUMBER_OF_CLIENTS=$(grep -c -E "^#vls " "/usr/local/etc/xray/vless.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "SHOW USER XRAY VLESS WS"
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
patchtls=/trickers-vlesswstls
patchnontls=/trickers-vlesswsntls
user=$(grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
harini=$(grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
vlesslink1="vless://${uuid}@cdn-dev.hotlink.com.my:$tls?path=$patchtls&security=tls&encryption=none&type=ws&host=${sts}${domain}&sni=cdn-dev.hotlink.com.my#${user}"
vlesslink2="vless://${uuid}@www.speedtest.net:$none?path=$patchnontls&encryption=none&type=ws&host=${domain}#${user}"
vlesslink3="vless://${uuid}@cdn.who.int:$none?path=$patchnontls&encryption=none&type=ws&host=cdn.who.int.${domain}#${user}"
vlesslink4="vless://${uuid}@162.159.134.61:$none?path=$patchnontls&encryption=none&type=ws&host=${sts}${domain}#${user}"
vlesslink5="vless://${uuid}@${sts}${domain}:$none?path=$patchnontls&encryption=none&type=ws&host=maingame.com.my#${user}"
clear
echo -e ""
echo -e " ${Lred}══════════════════════════════════════════════════════════════════${NC}"
echo -e " ${BGWHITE}                     [ XRAY VLESS WS ]                            ${NC}"
echo -e " ${Lred}══════════════════════════════════════════════════════════════════${NC}"
echo -e "Remarks          : ${user}"
echo -e "Domain           : ${domain}"
echo -e "IP/Host          : $MYIP"
echo -e "Port TLS         : $tls"
echo -e "Port None TLS    : $none"
echo -e "User ID          : ${uuid}"
echo -e "Encryption       : None"
echo -e "Network          : WebSocket"
echo -e "Path Tls         : $patchtls"
echo -e "Path None Tls    : $patchnontls"
echo -e "allowInsecure    : True/allow"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Pantang Larang $creditt Shop"
echo -e "‼️Aktiviti Berikut Adalah Dilarang(ID akan di ban tanpa notis & tiada refund)"
echo -e "\e[31m❌ Torrent (p2p, streaming p2p)"
echo -e "\e[31m❌ PS4"
echo -e "\e[31m❌ Porn"
echo -e "\e[31m❌ Spam Bug"
echo -e "\e[31m❌ Ddos Server"
echo -e "\e[31m❌ Mining Bitcoins"
echo -e "\e[31m❌ Abuse Usage"
echo -e "\e[31m❌ Multi-Login ID"
echo -e "\e[31m❌ Sharing Premium Config\e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Maxis         : ${vlesslink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Celcom        : ${vlesslink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Yes           : ${vlesslink3}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Digi          : ${vlesslink4}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Umobile       : ${vlesslink5}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created   :$harini"
echo -e "Expired   :$exp"
echo -e "Script By $creditt"
echo ""
read -n 1 -s -r -p "Press any key to back on menu maxisdigi"
maxisdigi
}
# FUCTION CREATE USER TROJAN
function menu7 () {
clear
trnone="$(cat ~/log-install.txt | grep -w "Xray Trojan Ws None Tls" | cut -d: -f2|sed 's/ //g')"
trws="$(cat ~/log-install.txt | grep -w "Xray Trojan Ws Tls" | cut -d: -f2|sed 's/ //g')"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
echo -e   "  \e[$back_text          \e[30m[\e[$box CREATE USER XRAY TROJAN WS TLS\e[30m ]\e[1m          \e[m"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
		read -rp "   Password: " -e user
		user_EXISTS=$(grep -w $user /usr/local/etc/xray/trojan.json | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
patchtls=/trickers-trojanwstls
patchnone=/trickers-trojanwsntls
read -p "   Bug Address (Example: www.google.com) : " address
read -p "   Bug SNI (Example : m.facebook.com) : " sni
read -p "   Expired (days) : " masaaktif
bug_addr=${address}.
bug_addr2=$address
if [[ $address == "" ]]; then
sts=$bug_addr2
else
sts=$bug_addr
fi
harini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#xray-trojan-tls$/a\#trws '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","password": "'""$user""'","email": "'""$user""'"' /usr/local/etc/xray/trojan.json
sed -i '/#xray-trojan-nontls$/a\#trws '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","password": "'""$user""'","email": "'""$user""'"' /usr/local/etc/xray/trojannone.json
systemctl restart xray@trojan
systemctl restart xray@trojannone
trojanlink1="trojan://${user}@cdn-dev.hotlink.com.my:443?path=$patchtls&security=tls&host=${sts}${domain}&type=ws&sni=cdn-dev.hotlink.com.my#${user}"
trojanlink2="trojan://${user}@www.speedtest.net:80?path=$patchnone&security=none&host=${domain}&type=ws#${user}"
trojanlink3="trojan://${user}@cdn.who.int:80?path=$patchnone&security=none&host=cdn.who.int.${domain}&type=ws#${user}"
trojanlink4="trojan://${user}@162.159.134.61:80?path=$patchnone&security=none&host=${domain}&type=ws#${user}"
clear
echo -e ""
echo -e "\e[$line════════[XRAY TROJAN WS TLS]════════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : ${MYIP}"
echo -e "Port Tls       : ${trws}"
echo -e "Port None TLS  : ${trnone}"
echo -e "Key            : ${user}"
echo -e "Security       : Auto"
echo -e "Network        : Websocket"
echo -e "Path Tls       : $patchtls"
echo -e "Path None Tls  : $patchnone"
echo -e "allowInsecure  : True/allow"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Pantang Larang $creditt Shop"
echo -e "‼️Aktiviti Berikut Adalah Dilarang(ID akan di ban tanpa notis & tiada refund)"
echo -e "\e[31m❌ Torrent (p2p, streaming p2p)"
echo -e "\e[31m❌ PS4"
echo -e "\e[31m❌ Porn"
echo -e "\e[31m❌ Spam Bug"
echo -e "\e[31m❌ Ddos Server"
echo -e "\e[31m❌ Mining Bitcoins"
echo -e "\e[31m❌ Abuse Usage"
echo -e "\e[31m❌ Multi-Login ID"
echo -e "\e[31m❌ Sharing Premium Config\e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Maxis)    : ${trojanlink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Celcom)   : ${trojanlink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Yes)      : ${trojanlink3}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Digi)     : ${trojanlink4}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created   :$harini"
echo -e "Expired   :$exp"
echo -e "Script By $creditt"
echo ""
read -n 1 -s -r -p "Press any key to back on menu maxisdigi"
maxisdigi
}
# FUCTION TRIAL USER TROJAN
function menu8 () {
clear
trnone="$(cat ~/log-install.txt | grep -w "Xray Trojan Ws None Tls" | cut -d: -f2|sed 's/ //g')"
trws="$(cat ~/log-install.txt | grep -w "Xray Trojan Ws Tls" | cut -d: -f2|sed 's/ //g')"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
echo -e   "  \e[$back_text          \e[30m[\e[$box TRIAL USER XRAY TROJAN WS TLS\e[30m ]\e[1m           \e[m"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
# Create Expried 
masaaktif="1"
exp=$(date -d "$masaaktif days" +"%Y-%m-%d")

# Make Random Username 
user=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`

patchtls=/trickers-trojanwstls
patchnone=/trickers-trojanwsntls
read -p "   Bug Address (Example: www.google.com) : " address
read -p "   Bug SNI (Example : m.facebook.com) : " sni
bug_addr=${address}.
bug_addr2=$address
if [[ $address == "" ]]; then
sts=$bug_addr2
else
sts=$bug_addr
fi
harini=`date -d "0 days" +"%Y-%m-%d"`
sed -i '/#xray-trojan-tls$/a\#trws '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","password": "'""$user""'","email": "'""$user""'"' /usr/local/etc/xray/trojan.json
sed -i '/#xray-trojan-nontls$/a\#trws '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","password": "'""$user""'","email": "'""$user""'"' /usr/local/etc/xray/trojannone.json
systemctl restart xray@trojan
systemctl restart xray@trojannone
trojanlink1="trojan://${user}@cdn-dev.hotlink.com.my:443?path=$patchtls&security=tls&host=${sts}${domain}&type=ws&sni=cdn-dev.hotlink.com.my#${user}"
trojanlink2="trojan://${user}@www.speedtest.net:443?path=$patchtls&security=tls&host=${sts}${domain}&type=ws&sni=www.speedtest.net#${user}"
trojanlink3="trojan://${user}@cdn.who.int:80?path=$patchnone&security=none&host=${sts}${domain}&type=ws#${user}"
trojanlink4="trojan://${user}@162.159.134.61:80?path=$patchnone&security=none&host=${sts}${domain}&type=ws#${user}"
clear
echo -e ""
echo -e "\e[$line═════[TRIAL XRAY TROJAN WS TLS]═════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : ${MYIP}"
echo -e "Port Tls       : ${trws}"
echo -e "Port None TLS  : ${trnone}"
echo -e "Key            : ${user}"
echo -e "Security       : Auto"
echo -e "Network        : Websocket"
echo -e "Path Tls       : $patchtls"
echo -e "Path None Tls  : $patchnone"
echo -e "allowInsecure  : True/allow"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Pantang Larang $creditt Shop"
echo -e "‼️Aktiviti Berikut Adalah Dilarang(ID akan di ban tanpa notis & tiada refund)"
echo -e "\e[31m❌ Torrent (p2p, streaming p2p)"
echo -e "\e[31m❌ PS4"
echo -e "\e[31m❌ Porn"
echo -e "\e[31m❌ Spam Bug"
echo -e "\e[31m❌ Ddos Server"
echo -e "\e[31m❌ Mining Bitcoins"
echo -e "\e[31m❌ Abuse Usage"
echo -e "\e[31m❌ Multi-Login ID"
echo -e "\e[31m❌ Sharing Premium Config\e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Maxis)    : ${trojanlink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Celcom)   : ${trojanlink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Yes)      : ${trojanlink3}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Digi)     : ${trojanlink4}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created   :$harini"
echo -e "Expired   :$exp"
echo -e "Script By $creditt"
echo ""
read -n 1 -s -r -p "Press any key to back on menu maxisdigi"
maxisdigi
}
function menu9 () {
trnone="$(cat ~/log-install.txt | grep -w "Xray Trojan Ws None Tls" | cut -d: -f2|sed 's/ //g')"
trws="$(cat ~/log-install.txt | grep -w "Xray Trojan Ws Tls" | cut -d: -f2|sed 's/ //g')"
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#trws " "/usr/local/etc/xray/trojan.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "SHOW USER XRAY TROJAN WS TLS"
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	grep -E "^#trws " "/usr/local/etc/xray/trojan.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
patchtls=/trickers-trojanwstls
patchnone=/trickers-trojanwsntls
user=$(grep -E "^#trws " "/usr/local/etc/xray/trojan.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
harini=$(grep -E "^#trws " "/usr/local/etc/xray/trojan.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^#trws " "/usr/local/etc/xray/trojan.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^#trws " "/usr/local/etc/xray/trojan.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
trojanlink1="trojan://${user}@cdn-dev.hotlink.com.my:443?path=$patchtls&security=tls&host=${sts}${domain}&type=ws&sni=cdn-dev.hotlink.com.my#${user}"
trojanlink2="trojan://${user}@www.speedtest.net:443?path=$patchtls&security=tls&host=${sts}${domain}&type=ws&sni=www.speedtest.net#${user}"
trojanlink3="trojan://${user}@cdn.who.int:80?path=$patchnone&security=none&host=${sts}${domain}&type=ws#${user}"
trojanlink4="trojan://${user}@162.159.134.61:80?path=$patchnone&security=none&host=${sts}${domain}&type=ws#${user}"
clear
echo -e ""
echo -e "\e[$line════════[XRAY TROJAN WS TLS]════════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : ${MYIP}"
echo -e "Port Tls       : ${trws}"
echo -e "Port None TLS  : ${trnone}"
echo -e "Key            : ${user}"
echo -e "Security       : Auto"
echo -e "Network        : Websocket"
echo -e "Path Tls       : $patchtls"
echo -e "Path None Tls  : $patchnone"
echo -e "allowInsecure  : True/allow"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Pantang Larang $creditt Shop"
echo -e "‼️Aktiviti Berikut Adalah Dilarang(ID akan di ban tanpa notis & tiada refund)"
echo -e "\e[31m❌ Torrent (p2p, streaming p2p)"
echo -e "\e[31m❌ PS4"
echo -e "\e[31m❌ Porn"
echo -e "\e[31m❌ Spam Bug"
echo -e "\e[31m❌ Ddos Server"
echo -e "\e[31m❌ Mining Bitcoins"
echo -e "\e[31m❌ Abuse Usage"
echo -e "\e[31m❌ Multi-Login ID"
echo -e "\e[31m❌ Sharing Premium Config\e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Maxis)    : ${trojanlink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Celcom)   : ${trojanlink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Yes)      : ${trojanlink3}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link (Digi)     : ${trojanlink4}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created   :$harini"
echo -e "Expired   :$exp"
echo -e "Script By $creditt"
echo ""
read -n 1 -s -r -p "Press any key to back on menu maxisdigi"
maxisdigi
}
# MENU XRAY VMESS VLESS TROJAN MAXIS DIGI YES CELCOM
clear
echo -e ""
echo -e "   \e[$line ══════════════════════════════════════════\e[m"
echo -e "    \e[$back_text     \e[30m[\e[$box VMESS MAXIS & DIGI CELCOM YES\e ]\e[30m     \e[m"
echo -e "   \e[$line ══════════════════════════════════════════\e[m"
echo -e "    \e[$number (•1)\e[m \e[$below XRAY VMESS MAXIS DIGI CELCOM YES\e[m"
echo -e "    \e[$number (•2)\e[m \e[$below XRAY VMESS TRIAL MAXIS DIGI CELCOM YES\e[m"
echo -e "    \e[$number (•3)\e[m \e[$below XRAY SHOW CONFIQ VMESS MAXIS DIGI CELCOM YES\e[m"
echo -e ""
echo -e "   \e[$number    >> Total :\e[m \e[$below ${total1} Client\e[m"
echo -e "   \e[$line ══════════════════════════════════════════\e[m"
echo -e "    \e[$back_text       \e[30m[\e[$box VLESS MAXIS & DIGI CELCOM\e ]\e[30m       \e[m"
echo -e "   \e[$line ══════════════════════════════════════════\e[m"
echo -e "    \e[$number (•4)\e[m \e[$below XRAY VLESS MAXIS DIGI CELCOM YES UMOBILE\e[m"
echo -e "    \e[$number (•5)\e[m \e[$below XRAY VLESS TRIAL MAXIS DIGI CELCOM YES UMOBILE\e[m"
echo -e "    \e[$number (•6)\e[m \e[$below XRAY SHOW CONFIQ VLESS MAXIS DIGI CELCOM YES\e[m"
echo -e ""
echo -e "   \e[$number    >> Total :\e[m \e[$below ${total2} Client\e[m"
echo -e "   \e[$line ══════════════════════════════════════════\e[m"
echo -e "    \e[$back_text       \e[30m[\e[$box TROJAN MAXIS & DIGI CELCOM\e ]\e[30m      \e[m"
echo -e "   \e[$line ══════════════════════════════════════════\e[m"
echo -e "    \e[$number (•7)\e[m \e[$below XRAY TROJAN MAXIS DIGI CELCOM YES UMOBILE\e[m"
echo -e "    \e[$number (•8)\e[m \e[$below XRAY TROJAN TRIAL MAXIS DIGI CELCOM YES UMOBILE\e[m"
echo -e "    \e[$number (•9)\e[m \e[$below XRAY TROJAN CONFIQ VLESS MAXIS DIGI CELCOM YES UMOBILE\e[m"
echo -e ""
echo -e "   \e[$number    >> Total :\e[m \e[$below ${total3} Client\e[m"
echo -e "   \e[$line ══════════════════════════════════════════\e[m"
echo -e "    \e[$back_text  \e[$box x)   MENU                              \e[m"
echo -e "   \e[$line ══════════════════════════════════════════\e[m"
echo -e "\e[$line"
read -rp "      Please Input Number  [1-9 or x] :  "  num
echo -e ""
if [[ "$num" = "1" ]]; then
menu1
elif [[ "$num" = "2" ]]; then
menu2
elif [[ "$num" = "3" ]]; then
menu3
elif [[ "$num" = "4" ]]; then
menu4
elif [[ "$num" = "5" ]]; then
menu5
elif [[ "$num" = "6" ]]; then
menu6
elif [[ "$num" = "7" ]]; then
menu7
elif [[ "$num" = "8" ]]; then
menu8
elif [[ "$num" = "9" ]]; then
menu9
elif [[ "$num" = "x" ]]; then
menu
else
clear
echo -e "\e[1;31mYou Entered The Wrong Number, Please Try Again!\e[0m"
sleep 1
menu
fi
