#/bin/bash
#Configuración de zona horaria
rm -f /etc/localtime && ln -s /usr/share/zoneinfo/America/Bogota /etc/localtime
#Creación deuser y group
groupadd -g grupos devops
useradd devops -u usuario -g grupos

#Realiza la creacion de la estructura de carpetas
mkdir -p /libre/devops/apps/aplicacion/
mkdir -p /libre/devops/logs/
mkdir -p /libre/devops/tmp
chown -R devops:devops /libre
chmod +x run.sh