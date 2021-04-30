#Descarga la imagen desde el repositorio

FROM registromatrixtech.jfrog.io/prisma2-imagenes/prisma2_rhel7:latest

USER devops

ARG JAR_FILE
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]