FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift

LABEL io.k8s.description="practice for using spring-boot, openshift, s2i" \
      io.k8s.display-name="spring-boot practice" \
      io.openshift.s2i.script-url=image:///usr/libexec/s2i \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="spring-boot"

ENV STI_SCRIPTS_PATH=/usr/libexec/s2i
ENV PATH $PATH:$STI_SCRIPTS_PATH

COPY ./.s2i/bin/* /usr/libexec/s2i/

EXPOSE 8080

RUN echo $PATH
CMD ["usage"]
