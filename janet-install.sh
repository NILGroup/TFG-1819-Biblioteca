s#!/bin/bash

#set -e
declare -r serverurl="github.com/darldil/TFG-Biblioteca.git"

echo "Programa de instalación de Janet."
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
echo -n "Escribe un nombre de usuario autorizado de GitHub: "
read gituser

echo -n "Escribe la contraseña de la cuenta de GitHub: "
read -s gitpass

echo

echo "-----------------------------------"
echo "Actualizando Sistema Operativo..."
sudo apt-get update >/dev/null
sudo apt-get upgrade >/dev/null

echo "Sistema Operativo actualizado."
echo "Instalando Python 3..."

sudo apt-get install -y build-essential checkinstall >/dev/null
sudo apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev zlib1g-dev unzip >/dev/null

cd /usr/src
sudo wget https://www.python.org/ftp/python/3.6.8/Python-3.6.8.tgz >/dev/null

sudo tar xzf Python-3.6.8.tgz >/dev/null

cd Python-3.6.8
sudo ./configure --enable-optimizations --with-zlib=/usr/include --with-ensurepip=install --with-shared >/dev/null
sudo make altinstall >/dev/null

sudo update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.6 1 >/dev/null
sudo update-alternatives --install /usr/bin/pip3 pip3 /usr/local/bin/pip3.6 1 >/dev/null


echo "Python 3 instalado..."
echo "Instalando Git..."

sudo apt-get -y install git-all >/dev/null

echo "Git instalado..."
echo "Instalando MongoDB..."
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4 >/dev/null
echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.0 main" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list >/dev/null
apt-get update >/dev/null
apt-get install -y mongodb-org >/dev/null

echo "Creando grupo y usuario..."
useradd -m -d /home/tfg-biblio -s /sbin/nologin -U tfg-biblio

echo "-----------------------------------"
echo "Descargando Janet..."
mkdir /home/tfg-biblio/tmp

declare repo=https://$gituser:$gitpass@$serverurl
echo $repo
git clone -b dev-server-0.9.1 $repo /home/tfg-biblio/tmp

echo "Instalando Janet..."
mkdir /home/tfg-biblio/janet
mv /home/tfg-biblio/tmp/Servidor/* /home/tfg-biblio/janet/
rm -rf /home/tfg-biblio/tmp
chown -R tfg-biblio:tfg-biblio /home/tfg-biblio/janet
chmod -R 777 /home/tfg-biblio/janet

echo "Instalando dependencias..."
pip3 install -r /home/tfg-biblio/janet/requirements.txt >/dev/null
sudo mv /home/tfg-biblio/tmp/Jarvis/regex_featurizer.py /usr/local/lib/python3.6/site-packages/rasa_nlu/featurizers/regex_featurizer.py

echo "Descargando Jarvis (temporal)..."
mkdir /home/tfg-biblio/tmp

declare repo=https://$gituser:$gitpass@$serverurl
echo $repo
git clone -b dev-jarvis-0.9 $repo /home/tfg-biblio/tmp

echo "Instalando Jarvis..."
mkdir /home/tfg-biblio/Jarvis
mv /home/tfg-biblio/tmp/Jarvis/* /home/tfg-biblio/Jarvis/
rm -rf /home/tfg-biblio/tmp
chown -R tfg-biblio:tfg-biblio /home/tfg-biblio/Jarvis
chmod -R 777 /home/tfg-biblio/Jarvis
sudo -u tfg-biblio /home/tfg-biblio/
sudo python3 -m spacy download es_core_news_sm >/dev/null

echo "-----------------------------------"
echo "Creando daemons..."
mv /home/tfg-biblio/janet/janet.service /etc/systemd/system/janet.service
mv /home/tfg-biblio/Jarvis/jarvisactions.service /etc/systemd/system/jarvisactions.service
mv /home/tfg-biblio/Jarvis/jarvis.service /etc/systemd/system/jarvis.service

systemctl enable janet.service
systemctl enable jarvisactions.service
systemctl enable jarvis.service

echo "-----------------------------------"
echo "Entrenando Jarvis por primera vez, esta operación durará varios minutos..."
cd /home/tfg-biblio/Jarvis/
sudo -u tfg-biblio python3 JarvisMain.py -t all

echo "-----------------------------------"
echo "Creando servicio del destructor imperial"
crontab -u tfg-biblio -l > mycron
echo "*/15 * * * * tfg-biblio python3 /home/tfg-biblio/janet/DestructorImperial.py" >> mycron
crontab -u tfg-biblio mycron
rm mycron

echo "Arrancando servicios"
systemctl start janet.service
systemctl start jarvisactions.service
systemctl start jarvis.service

echo "-----------------------------------"
echo "Instalación realizada con éxito! (Por ahora)"
exit 0

