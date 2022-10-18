## Bienvenido a Venom-Wifi

<h3><p align="center">Advertencia</p></h3>

Cualquier acción o actividad relacionada con Venom-Wifi es de su exclusiva responsabilidad. El uso indebido de este conjunto de herramientas puede dar lugar a cargos penales contra las personas en cuestión. Los contribuyentes no serán responsables en caso de que se presenten cargos penales contra cualquier persona que haga un uso indebido de este conjunto de herramientas para infringir la ley.

Este conjunto de herramientas contiene materiales que pueden ser potencialmente dañinos o peligrosos para las redes sociales. Consulte las leyes de su provincia/país antes de acceder, usar o de cualquier otra forma utilizar esto de manera incorrecta.

Esta herramienta está hecha solo con fines educativos. No intente violar la ley con nada de lo contenido aquí. Si esta es tu intención, entonces ¡Vete de aquí!

Solo demuestra "cómo funciona el phishing". No debe hacer un mal uso de la información para obtener acceso no autorizado a las redes sociales de otra persona. Sin embargo, puede probar esto bajo su propio riesgo.

##

Este es un script que automatiza la obtención del wpa handshake.  Cuando un usuario se conecta a una red wifi ocurre lo que se conoce como 4-way
handshake, este proceso transmite 4 mensajes para poder confirmar que ambos el usuario y el router tienen las credenciales correctas para empezar 
la comunicación (tu conexión a internet). Este con el handshake obtenido se puede crakear la contraseña mediante fuerza bruta. Además este script
tiene la función para tumbar una red wifi por completo sin necesidad de autenticación "Muy útil si lo que quieres es jugar una pequeña broma" pero
recuerda que si tumbas la red por mas de 5 horas, podrias dañar el router al que estas atacando. 
##

## Recomendación

Antes de iniciar se recomienda para esta clase de ataques a redes wifi, obtener una antena wifi rompemuros. La más popular en el mundo del pentesting es 
la antena de marca ALFA o antenas con un chipset Ralink.

<p align="left">
	<img src="https://i.imgur.com/wE0eG8t.jpg" width="30%" height="30%">
</p>

### Instalación

Clonar el repositorio y cambiar los permisos

```markdown
git clone https://github.com/Alcatraz2033/venom-wifi.git
cd venom-wifi
chmod +x venom-wifi.sh
sudo ./venom-wifi.sh
```

## Inicio

Selecciona la opcion que prefieras, puedes elejir entre atacar directamente la red o crackear la contraseña por fuerza bruta con ataque por diccionario. (Muy pronto se añadira el ataque Evil Twin)

<p align="left">
	<img src="https://i.imgur.com/PB6TxQ7.png" width="60%" height="60%" align="">
</p>

## Obterner Handshake

Al iniciar se abrira una terminal de xterm y mostrará gradualmente las redes wifi disponibles, una vez veas la red que vas a atacar, da clic sobre la
terminal xterm y luego preciona ctrl + C. La detección de red finalizará y podras cerrar la terminal dando clic en el botón cerrar "X".
Despues aparecerá el listado de redes disponibles, selecionas la que gustes y empieza el ataque.

<p align="center">
	<img src="https://i.imgur.com/xPt2Psi.png" width="100%" height="100%" align="">
</p>

## Resultado Final

Una vez obtenido el handshake, el programa automaticamente se serrará y guardará el archivo.cap en la carpeta capturas con el nombre de la red comprometida.
<p align="center">
	<img src="https://i.imgur.com/4xLFWjz.png" width="100%" height="100%" align="">
</p>

## Crackeo de Contraseña

Crackeo de contraseña por fuerza bruta con ataque de diccionario, escoje entre el diccionario por defecto o selecciona tu porpio diccioanrio de contraseñas.
<p align="center">
	<img src="https://i.imgur.com/HEQAWxi.png" width="100%" height="100%" align="">
</p>

## Tumbar la Red

Sigues los mismos pasos de la parte anterior pero cambias a la opcion de "Tumbar la red", automáticamente comenzará el ataque Dos a la red wifi seleccionada.
Para detener el ataque preciona ctrl + C en la terminal principal.


<p align="center">
	<img src="https://i.imgur.com/dStEmWc.png" width="100%" height="100%" align="">
</p>
