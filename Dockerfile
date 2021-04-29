#Descarga la imagen desde el repositorio

FROM registry.access.redhat.com/rhel7/rhel

#realiza la instalacion de JAVA JDK11
RUN yum -y install java-11-openjdk.x86_64 java-11-openjdk-devel.x86_64
RUN yum -y install wget
RUN yum -y install zip
RUN yum -y install unzip

#Actualiza la versión del S.O
RUN yum -y update

#Configuración de zona horaria
RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/America/Bogota /etc/localtime

#Creación deuser y group
RUN groupadd -g grupos devops
RUN useradd devops -u usuario -g grupos

#Realiza la creacion de la estructura de carpetas
RUN mkdir -p /libre/devops/apps/aplicacion/
RUN mkdir -p /libre/devops/logs/
