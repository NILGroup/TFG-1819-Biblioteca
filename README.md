# TFG Biblioteca
Repositorio del TFG "Asistente virtual para servicios de la biblioteca de la UCM".
Facultad de Informática de la Universidad Complutense de Madrid.
Curso 2018-2019.

Autores: Mauricio Abbati Loureiro y Jose Luis Moreno Varillas.
Directores: Alberto Díaz Esteban y Antonio Fernando García Sevilla.

**Instalación**

Los instaladores proporcionados en este repositorios han sido diseñados para:

 - Debian 'Jessie' y 'Stretch'
 - Ubuntu 'Trusty', 'Xenial' y 'Bionic'

*Es necesario ejecutar el script de instalación como superusuario.

Existen tres instaladores:

 1. Janet-full-install: Instala todos los componentes del sistema.
 2. Janet-server-install: Instala todos los módulos del sistema excepto el PLN.
 3. Janet-jarvis-install: Instala solo el módulo PLN.

IMPORTANTE! Una vez instalado uno de los módulos parciales, no debe ejecutarse el instalador completo, en su lugar, utiliza el otro instalador parcial.

Para instalar el sistema es necesario disponer de las carpetas Servidor y/o Jarvis (en función del tipo de instalación) y los ficheros 'wskey.conf' y 'bibliotecas.json'. Todos estos ficheros deben estar en el mismo directorio que el script de instalación. En caso de no encontrarse alguno de estos ficheros la instalación no continuará.
