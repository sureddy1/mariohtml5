FROM tomcat:9

RUN rm -rf /usr/local/tomcat/webapps && rm -fr /usr/local/tomcat/logs

## Create non-root user 
RUN useradd -ms /bin/bash mario \
    && usermod -aG mario mario \
    && su -c "umask 022" mario \
    && chown -R mario:mario /usr/local/tomcat

RUN mkdir /usr/local/tomcat/logs \
    && mkdir -p /usr/local/tomcat/webapps/ROOT \
    && chown -R mario:mario /usr/local/tomcat/logs \
    && chown -R mario:mario /usr/local/tomcat/webapps/ROOT

USER mario

ADD webapp/ /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080
CMD ["catalina.sh", "run"]
