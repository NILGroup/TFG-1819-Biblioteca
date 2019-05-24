# TFG Biblioteca
Repositorio del TFG "Asistente virtual para servicios de la biblioteca de la UCM".
Facultad de Informática de la Universidad Complutense de Madrid.
Curso 2018-2019.

Autores: Mauricio Abbati Loureiro y Jose Luis Moreno Varillas.
Directores: Alberto Díaz Esteban y Antonio Fernando García Sevilla.


**Instalación en servidor**

Los instaladores proporcionados en este repositorios han sido diseñados para:

 - Debian 'Jessie' y 'Stretch'
 - Ubuntu 'Trusty', 'Xenial' y 'Bionic'

*Es necesario ejecutar el script de instalación como superusuario.

Existen tres instaladores:

 1. Janet-full-install: Instala todos los componentes del sistema.
 2. Janet-server-install: Instala todos los módulos del sistema excepto el PLN.
 3. Janet-jarvis-install: Instala solo el módulo PLN.

IMPORTANTE! Una vez instalado uno de los módulos parciales, no debe ejecutarse el instalador completo, en su lugar, utiliza el otro instalador parcial.

Para instalar el sistema es necesario disponer de las carpetas Servidor y/o Jarvis (en función del tipo de instalación) y el fichero 'wskey.conf'. Todos estos ficheros deben estar en el mismo directorio que el script de instalación. En caso de no encontrarse alguno de estos ficheros la instalación no continuará.

El archivo 'wskey.conf' no se proporciona en este repositorio, dado que contiene información confidencial. Para conseguir este fichero, ponte en contacto con los directores del proyecto.

**Instalación en dispositivos móviles**

En iOS puedes instalar la aplicación entrando en la App Store y escribiendo en el buscador "Janet ucm". También puedes acceder directamente pulsando [aquí](https://itunes.apple.com/us/app/janet/id1451052771?l=es&ls=1&mt=8)

En Android puedes instalar la aplicación entrando en la Play Store y escribiendo en el buscador "Janet". También puedes acceder directamente pulsando [aquí](https://play.google.com/store/apps/details?id=ucm.fdi.android.speechtotext&hl=es_419)

Si no quieres instalar la aplicación a través de la Play Store, puedes instalar el apk directamente descargandolo desde este repositorio, en la sección [Releases](https://github.com/NILGroup/TFG-1819-Biblioteca/releases)
