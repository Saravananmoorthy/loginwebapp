FROM ubuntu:16.04
RUN rm -rf /var/lib/apt/lists/ && \
    apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/ && \
    rm -rf /var/cache/oracle-jdk8-installer;
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre
RUN export JAVA_HOME
RUN mkdir -p "$CATALINA_HOME" && apt-get update
WORKDIR $CATALINA_HOME
ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.5.50
ENV TOMCAT_TGZ_URL https://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin
RUN set -x \
    && wget $TOMCAT_TGZ_URL/apache-tomcat-$TOMCAT_VERSION.tar.gz \
    && tar -xvf apache-tomcat-$TOMCAT_VERSION.tar.gz --strip-components=1
ADD ./target/LoginWebApp.war $CATALINA_HOME/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
