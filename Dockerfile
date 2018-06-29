FROM tomcat:9

RUN rm -rf /usr/local/tomcat/webapps/ROOT/* && rm -fr /usr/local/tomcat/logs

ADD webapp/ /usr/local/tomcat/webapps/ROOT/

## Create non-root user 
RUN useradd -ms /bin/bash mario \
    && usermod -aG mario mario \
    && su -c "umask 022" mario \
    && chown -R mario:mario /usr/local/tomcat

USER mario

RUN mkdir /usr/local/tomcat/logs && chown -R mario:mario /usr/local/tomcat/logs

EXPOSE 8080
CMD ["catalina.sh", "run"]
