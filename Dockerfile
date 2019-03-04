FROM registry.access.redhat.com/jboss-webserver-5/webserver50-tomcat9-openshift
CMD mkdir /opt/spring-boot/
COPY ./openshift-practice-0.0.1-SNAPSHOT.jar /opt/spring-boot/
CMD java -jar /opt/spring-boot/openshift-practice-0.0.1-SNAPSHOT.jar
