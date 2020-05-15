FROM jetty:9.4.27-jre11-slim

COPY ./target/hapi-fhir-jpaserver.war /hapi/hapi-fhir-jpaserver.war
COPY ./src/main/resources/magic8ball-context.xml /var/lib/jetty/webapps/magic8ball-context.xml

# Copy the default config file to the config directory location. It might be overridden by the docker host.
COPY ./src/main/resources/hapi.properties /hapi/hapi.properties

USER jetty:jetty
EXPOSE 8080
CMD ["java", "-Xmx8g", "-jar","/usr/local/jetty/start.jar", "-Dhapi.properties=/hapi/hapi.properties"]


#FROM hapiproject/hapi:base as build-hapi
#
#ARG HAPI_FHIR_URL=https://github.com/jamesagnew/hapi-fhir/
#ARG HAPI_FHIR_BRANCH=master
#ARG HAPI_FHIR_STARTER_URL=https://github.com/hapifhir/hapi-fhir-jpaserver-starter/
#ARG HAPI_FHIR_STARTER_BRANCH=master
#
#RUN git clone --branch ${HAPI_FHIR_BRANCH} ${HAPI_FHIR_URL}
#WORKDIR /tmp/hapi-fhir/
#RUN /tmp/apache-maven-3.6.2/bin/mvn dependency:resolve
#RUN /tmp/apache-maven-3.6.2/bin/mvn install -DskipTests
#
#WORKDIR /tmp
#RUN git clone --branch ${HAPI_FHIR_STARTER_BRANCH} ${HAPI_FHIR_STARTER_URL}
#
#WORKDIR /tmp/hapi-fhir-jpaserver-starter
#RUN /tmp/apache-maven-3.6.2/bin/mvn clean install -DskipTests
#
#FROM tomcat:9-jre11
#
#RUN mkdir -p /data/hapi/lucenefiles && chmod 775 /data/hapi/lucenefiles
#COPY --from=build-hapi /tmp/hapi-fhir-jpaserver-starter/target/*.war /usr/local/tomcat/webapps/
#
#EXPOSE 8080
#
#CMD ["catalina.sh", "run"]