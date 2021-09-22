FROM tomcat:8.5.50-jdk8-openjdk

# variaveis para tornar o docker file dinâmico
ARG WAR_FILE
ARG CONTEXT

# deploy app gerada no workspace do jenkins para dentro do docker
COPY ${WAR_FILE}  /usr/local/tomcat/webapps/${CONTEXT}.war