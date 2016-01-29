FROM cursor/mbase

MAINTAINER Ryan Pederson <ryan@pederson.ca>

ENV DEBIAN_FRONTEND="noninteractive" \
    TERM="xterm"

RUN echo "deb http://shell.ninthgate.se/packages/debian wheezy main" > /etc/apt/sources.list.d/plexmediaserver.list && \
    curl http://shell.ninthgate.se/packages/shell-ninthgate-se-keyring.key | apt-key add - && \
    apt-get -q update && \
    apt-get install -qy --force-yes plexmediaserver && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

VOLUME ["/volumes/config","/volumes/media"]

ADD ./start.sh /start.sh
ADD ./Preferences.xml /Preferences.xml
RUN chmod u+x  /start.sh

ENV RUN_AS_ROOT="true" \
    CHANGE_DIR_RIGHTS="false" \
    CHANGE_CONFIG_DIR_OWNERSHIP="true" \
    HOME="/volumes/config"

EXPOSE 32400
EXPOSE 32443

CMD ["/start.sh"]
