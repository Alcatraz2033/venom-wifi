## Bienvenido a Auto Handshake

Este es un script que automatiza la obtención del wpa handshake.  Cuando un usuario se conecta a una red wifi ocurre lo que se conoce como 4-way
handshake, este proceso transmite 4 mensajes para poder confirmar que ambos el usuario y el router tienen las credenciales correctas para empezar 
la comunicación (tu conexión a internet). Este con el handshake obtenido se puede crakear la contraseña mediante fuerza bruta. Además este script
tiene la función para tumbar una red wifi por completo sin necesidad de autenticación "Muy útil si lo que quieres es jugar una pequeña broma" pero
recuerda que si tumbas la red por mas de 5 horas, podrias dañar el router al que estas atacando. 

### Instalación

Clonar el repositorio y cambiar los permisos

```markdown
git clone https://github.com/Alcatraz2033/auto-handshake.git

cd Auto-handshake

mkdir capturas

chmod +x handshake.sh

sudo handshake.sh

```

## Inicio

Selecciona la interfaz de red que utilizaras para el ataque "En este caso utilizo una antena Alfa rompe muros", automáticamente se eliminarán procesos que
puedan interferir con el ataque.

<p align="center">
	<img src="https://i.imgur.com/Du9qNBq.png" width="60%" height="60%" align="">
</p>

## Obterner Handshake

Al iniciar se abrira una terminal de xterm y mostrará gradualmente las redes wifi disponibles, una vez veas la red que vas a atacar, da clic sobre la
terminal xterm y luego preciona ctrl + C. La detección de red finalizará y podras cerrar la terminal dando clic en la opcion de cerrar "X".
Despues de aparecerá el listado de redes disponibles, selecionas la que gustes y empieza el ataque.

<p align="center">
	<img src="https://i.imgur.com/zywUH2z.png" width="100%" height="100%" align="">
</p>

## Tumbar la Red

Sigues los mismos pasos de la parte anterior pero cambias a la opcion de "Tumbar la red", automáticamente comenzará el ataque Dos a la red wifi seleccionada.
Para detener el ataque preciona ctrl + C en la terminal principal.


<p align="center">
	<img src="https://i.imgur.com/H33jYTf.png" width="100%" height="100%" align="">
</p>
