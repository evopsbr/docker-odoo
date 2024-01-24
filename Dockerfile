FROM paloschisistemas/docker-odoo-base:17.0

##### Repositórios #####
WORKDIR /opt/odoo

RUN wget https://github.com/odoo/odoo/archive/17.0.zip -O odoo.zip && \
    wget https://github.com/paloschisistemas/odoo-brasil/archive/17.0.zip -O odoo-brasil.zip

RUN unzip -q odoo.zip && rm odoo.zip && mv odoo-17.0 odoo && \
    unzip -q odoo-brasil.zip && rm odoo-brasil.zip && mv odoo-brasil-17.0 odoo-brasil && \
    cd odoo && find . -name "*.po" -not -name "pt_BR.po" -not -name "pt.po"  -type f -delete && \
    find . -path "*l10n_*" -delete && \
    rm -R debian && rm -R doc && rm -R setup && cd ..

RUN pip3 install -r /opt/odoo/odoo/requirements.txt
RUN pip3 install -r /opt/odoo/odoo-brasil/requirements.txt

##### Configurações Odoo #####

ADD deploy/odoo.conf /etc/odoo/
RUN chown -R odoo:odoo /opt && \
    chown -R odoo:odoo /etc/odoo/odoo.conf

RUN mkdir /opt/.ssh && \
    chown -R odoo:odoo /opt/.ssh

ADD bin/autoupdate /opt/odoo
ADD bin/entrypoint.sh /opt/odoo
RUN chown odoo:odoo /opt/odoo/autoupdate && \
    chmod +x /opt/odoo/autoupdate && \
    chmod +x /opt/odoo/entrypoint.sh

WORKDIR /opt/odoo

ENV PYTHONPATH=$PYTHONPATH:/opt/odoo/odoo
ENV PG_HOST=localhost
ENV PG_PORT=5432
ENV PG_USER=odoo
ENV PG_PASSWORD=odoo
ENV PG_DATABASE=False
ENV ODOO_PASSWORD=admin
ENV PORT=8069
ENV LOG_FILE=/var/log/odoo/odoo.log
ENV LONGPOLLING_PORT=8072
ENV WORKERS=5
ENV DISABLE_LOGFILE=0
ENV USE_SPECIFIC_REPO=0
ENV TRUSTCODE_APPS=0
ENV TRUSTCODE_ENTERPRISE=0
ENV TRUSTCODE_ONLY=0
ENV TIME_CPU=6000
ENV TIME_REAL=7200
ENV DB_FILTER=False
ENV EXTRA_ARGS=''

VOLUME ["/opt/", "/etc/odoo"]
ENTRYPOINT ["/opt/odoo/entrypoint.sh"]
CMD ["/usr/bin/supervisord"]
