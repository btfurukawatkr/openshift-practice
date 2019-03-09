FROM registry.access.redhat.com/jboss-webserver-5/webserver50-tomcat9-openshift
CMD mkdir /opt/spring-boot/
COPY ./ /opt/spring-boot/
CMD /opt/spring-boot/.s2i/bin/assemble
CMD /opt/spring-boot/.s2i/bin/run

