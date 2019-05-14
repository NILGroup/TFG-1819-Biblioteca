#!/bin/bash

DIRECTORY=$(cd `dirname $0` && pwd)

set -e

echo "Programa de instalación de Janet. (Solo Servidor)"
echo "-----------------------------------"

if ! [ $(id -u) = 0 ]; then
   echo "Este script solo puede ser ejecutado por un superusuario." >&2
   exit 1
fi

if [ $SUDO_USER ]; then
    real_user=$SUDO_USER
else
    real_user=$(whoami)
fi

echo -n "Seguro que quieres instalar Janet (y/n)? "
read answer
if [ "$answer" != "${answer#[Nn]}" ] ;then
	exit 0
fi

echo "-----------------------------------"
echo "Comprobando integridad de ficheros"


if [ ! -d "Servidor" ] || [ ! -f "wskey.conf" ]; then
    echo "ERROR! No se localizan los ficheros de instalación." >&2
    exit 1
else
    echo "Ok"
fi

echo "-----------------------------------"
export DEBIAN_FRONTEND=noninteractive
echo "Actualizando apt..."
apt-get update >/dev/null

echo "Instalando Python 3..."

apt-get install -yq build-essential checkinstall >/dev/null
apt-get install -yq libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev zlib1g-dev unzip >/dev/null

apt-get install -yq python3 python3-dev python3-pip >/dev/null


echo "Ok"
echo "-----------------------------------"
echo "Instalando Git..."

apt-get -yq install git-all >/dev/null

echo "Ok"
echo "-----------------------------------"
echo "Instalando MongoDB..."

if ! [ -x "$(command -v mongo)" ]; then
    apt-get -yq install dirmngr >/dev/null
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4

    source /etc/os-release

    if [ $ID == 'debian' ]; then
        if [ $VERSION_ID == "9" ]; then
            echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.0 main" >  /etc/apt/sources.list.d/mongodb-org-4.0.list
        else
            echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/4.0 main" >  /etc/apt/sources.list.d/mongodb-org-4.0.list
        fi
    else
        if [ $VERSION_ID == "18.04" ]; then
            echo "deb http://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" >  /etc/apt/sources.list.d/mongodb-org-4.0.list
        elif [ $VERSION_ID == "16.04" ]; then
            echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" >  /etc/apt/sources.list.d/mongodb-org-4.0.list
        else
            echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/4.0 multiverse" >  /etc/apt/sources.list.d/mongodb-org-4.0.list
        fi
    fi

    apt-get update >/dev/null
    apt-get install -yq mongodb-org >/dev/null

    printf "[Unit]\nDescription=High-performance, schema-free document-oriented database\nAfter=network.target\n\n[Service]\nUser=mongodb\n ExecStart=/usr/bin/mongod --quiet --config /etc/mongod.conf\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/mongodb.service

    systemctl enable mongodb
    systemctl start mongodb
fi

echo "Ok"
echo "-----------------------------------"
echo "Creando grupo y usuario..."
if ! id "tfg-biblio" >/dev/null 2>&1; then
    useradd -m -d /home/tfg-biblio -s /sbin/nologin -U tfg-biblio
    echo "Ok"
else
    echo "El usuario 'tfg-biblio' ya existe, continúo..."
fi

echo "-----------------------------------"

echo "Instalando Janet..."
mkdir /home/tfg-biblio/janet
mv Servidor/* /home/tfg-biblio/janet/
mv wskey.conf /home/tfg-biblio/janet/
chown -R tfg-biblio:tfg-biblio /home/tfg-biblio/janet
chmod -R 777 /home/tfg-biblio/janet

echo "Ok"
echo "-----------------------------------"
echo "Instalando dependencias..."
pip3 install -r /home/tfg-biblio/janet/requirements.txt >/dev/null

echo "Ok"
echo "-----------------------------------"
echo "Preparando Base de datos..."

mongoimport --db janet --collection localizaciones --file /home/tfg-biblio/janet/bibliotecas.json

mongo <<EOF
use janet
db.localizaciones.createIndex({kw: "text"});
exit
EOF

echo "Ok"
echo "-----------------------------------"
echo "Creando daemons..."
mv /home/tfg-biblio/janet/janet.service /etc/systemd/system/janet.service

systemctl enable janet.service

echo "Ok"
echo "-----------------------------------"
echo "Creando servicio del destructor imperial"
mycron=${TMPDIR:-/tmp}/xyz.$$
trap "rm -f $tmp; exit 1" 0 1 2 3 13 15
echo "*/15 * * * * tfg-biblio python3 /home/tfg-biblio/janet/DestructorImperial.py" >> $mycron
crontab -u tfg-biblio $mycron
rm -f $mycron

echo "Arrancando servicios"
systemctl start janet.service

echo "Ok"
echo "-----------------------------------"

echo "Borrando archivos temporales"
if [ -d "$DIRECTORY/Servidor" ]; then rm -Rf $DIRECTORY/Servidor; fi
if [ -d "$DIRECTORY/Clientes" ]; then rm -Rf $DIRECTORY/Clientes; fi
if [ -f "$DIRECTORY/bibliotecas.json" ]; then rm $DIRECTORY/bibliotecas.json; fi
if [ -f "$DIRECTORY/.gitignore" ]; then rm $DIRECTORY/.gitignore; fi
if [ -f "$DIRECTORY/README.md" ]; then rm $DIRECTORY/README.md; fi
if [ -f "$DIRECTORY/LICENSE.md" ]; then rm $DIRECTORY/LICENSE.md; fi

echo "Ok"
echo "-----------------------------------"
echo "Instalación realizada con éxito!"
exit 0

