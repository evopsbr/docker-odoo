### Repositorio EVOPS
#####################
FROM evopsbr/docker-odoo-base:14.0

## Diretorio de trabalho ODOO
WORKDIR /opt/odoo

### Download dos pacotes e dependencias.
########################################

## Download ODOO.
RUN wget https://github.com/odoo/odoo/archive/14.0.zip -O odoo.zip && \
    unzip -q odoo.zip && rm odoo.zip && mv odoo-14.0 odoo

RUN wget https://codeload.github.com/OCA/bank-payment/zip/refs/heads/14.0 -O bank-payment.zip && \
    unzip -q bank-payment.zip && rm bank-payment.zip && mv bank-payment-14.0 bank-payment

RUN wget https://codeload.github.com/OCA/account-payment/zip/refs/heads/14.0 -O account-payment.zip && \
    unzip -q account-payment.zip && rm account-payment.zip && mv account-payment-14.0 account-payment

## Download WEB.
#RUN wget https://github.com/oca/web/archive/14.0.zip -O web.zip && \
#    unzip -q web.zip && rm web.zip && mv web-14.0 web
    
## Download account-reconcile.
RUN wget https://codeload.github.com/OCA/account-reconcile/zip/refs/heads/14.0 -O account-reconcile.zip && \
    unzip -q account-reconcile.zip && rm account-reconcile.zip && mv account-reconcile-14.0 account-reconcile
#RUN wget https://github.com/oca/account-reconcile/archive/14.0.zip -O account-reconcile.zip && \
#    unzip -q account-reconcile.zip && rm account-reconcile.zip && mv account-reconcile-14.0 account-reconcile

## Download server-ux.
#RUN wget https://github.com/oca/server-ux/archive/14.0.zip -O server-ux.zip && \
#    unzip -q server-ux.zip && rm server-ux.zip && mv server-ux-14.0 server-ux
    
## Download reporting-engine.
#RUN wget https://github.com/oca/reporting-engine/archive/14.0.zip -O reporting-engine.zip && \
#    unzip -q reporting-engine.zip && rm reporting-engine.zip && mv reporting-engine-14.0 reporting-engine

## Download account-financial-reporting.
#RUN wget https://github.com/oca/account-financial-reporting/archive/14.0.zip -O account-financial-reporting.zip && \
#    unzip -q account-financial-reporting.zip && rm account-financial-reporting.zip && mv account-financial-reporting-14.0 account-financial-reporting
    
## Download COD137-APPS.
#RUN wget https://github.com/code-137/odoo-apps/archive/14.0.zip -O code137-apps.zip && \
#    unzip -q code137-apps.zip && rm code137-apps.zip && mv odoo-apps-14.0 code137-apps
    
## Download QUEUE.
#RUN wget https://codeload.github.com/OCA/queue/zip/refs/heads/14.0 -O queue.zip && \
#    unzip -q queue.zip && rm queue.zip && mv queue-14.0 queue
    
## Download account-financial-tools.
#RUN wget https://codeload.github.com/OCA/account-financial-tools/zip/refs/heads/14.0 -O account-financial-tools.zip && \
#    unzip -q account-financial-tools.zip && rm account-financial-tools.zip && mv account-financial-tools-14.0 account-financial-tools

## Download reporting-engine.
#RUN wget https://codeload.github.com/OCA/reporting-engine/zip/refs/heads/14.0 -O reporting-engine.zip && \
#    unzip -q reporting-engine.zip && rm reporting-engine.zip && mv reporting-engine-14.0 reporting-engine

## Download edi.
#RUN wget https://codeload.github.com/OCA/edi/zip/refs/heads/14.0 -O edi.zip && \
#    unzip -q edi.zip && rm edi.zip && mv edi-14.0 edi

## Download mis-builder.
#RUN wget https://github.com/oca/mis-builder/archive/14.0.zip -O mis-builder.zip && \
#    unzip -q mis-builder.zip && rm mis-builder.zip && mv mis-builder-14.0 mis-builder
    
## Download commission.
#RUN wget https://github.com/OCA/commission/archive/14.0.zip -O commission.zip && \
#    unzip -q commission.zip && rm commission.zip && mv commission-14.0 commission

## Download design-themes.
#RUN wget https://github.com/odoo/design-themes/archive/14.0.zip -O design-themes.zip && \
#    unzip -q design-themes.zip && rm design-themes.zip && mv design-themes-14.0 design-themes

## Download manufacture.
#RUN wget https://codeload.github.com/OCA/manufacture/zip/refs/heads/14.0 -O manufacture.zip && \
#    unzip -q manufacture.zip && rm manufacture.zip && mv manufacture-14.0 manufacture

## Download odoo-brasil.
#RUN wget https://github.com/evopsbr/odoo-brasil/archive/14.0.zip -O odoo-brasil.zip && \
#    unzip -q odoo-brasil.zip && rm odoo-brasil.zip && mv odoo-brasil-14.0 odoo-brasil

## Download server-tools.
#RUN wget https://codeload.github.com/OCA/server-tools/zip/refs/heads/14.0 -O server-tools.zip && \
#    unzip -q server-tools.zip && rm server-tools.zip && mv server-tools-14.0 server-tools

## Install community-data-files requirements.
#RUN wget https://codeload.github.com/OCA/community-data-files/zip/refs/heads/14.0 -O community-data-files.zip && \
#    unzip -q community-data-files.zip && rm community-data-files.zip && mv community-data-files-14.0 community-data-files

## Install l10n-brazil requirements.
RUN wget https://codeload.github.com/OCA/l10n-brazil/zip/refs/heads/14.0 -O l10n-brazil.zip && \
    unzip -q l10n-brazil.zip && rm l10n-brazil.zip && mv l10n-brazil-14.0 l10n-brazil

## Remocao dos add-ons que nao sao pt_BR ou pt.
RUN cd odoo && find . -name "*.po" -not -name "pt_BR.po" -not -name "pt.po"  -type f -delete && \
    rm -R debian && rm -R doc && rm -R setup && cd ..
#    find . -path "*l10n_*" -delete && \

     

### Instalacao e atualizacao de libs e dependencias.
####################################################

## Update PIP3.
RUN pip3 install setuptools && pip3 install --no-cache-dir --upgrade pip

## Install ODOO requirements.
RUN pip3 install --no-cache-dir -r odoo/requirements.txt

## Install BANK-PAYMENT requirements.
RUN pip3 install --no-cache-dir -r bank-payment/requirements.txt

## Install ACCOUNT-PAYMENT requirements.
RUN pip3 install --no-cache-dir -r account-payment/requirements.txt

## Install WEB requirements.
#RUN pip3 install --no-cache-dir -r web/requirements.txt && \
#    pip3 install --no-cache-dir -r web/oca_dependencies.txt

## Install account-reconcile requirements.
RUN pip3 install --no-cache-dir -r account-reconcile/requirements.txt

## Install server-ux requirements.
#RUN pip3 install --no-cache-dir -r server-ux/requirements.txt && \
#    pip3 install --no-cache-dir -r server-ux/test-requirements.txt 
    
## Install reporting-engine requirements.
#RUN pip3 install --no-cache-dir -r reporting-engine/requirements.txt

## Install account-financial-reporting requirements.
#RUN pip3 install --no-cache-dir -r account-financial-reporting/requirements.txt
    
## Install COD137-APPS requirements.
#RUN pip3 install --no-cache-dir -r code137-apps/requirements.txt
    
## Install QUEUE requirements.
#RUN pip3 install --no-cache-dir -r queue/requirements.txt
    
## Install account-financial-tools requirements.
#RUN pip3 install --no-cache-dir -r account-financial-tools/requirements.txt

## Install reporting-engine requirements.
#RUN pip3 install --no-cache-dir -r reporting-engine/requirements.txt

## Install edi requirements.
#RUN pip3 install --no-cache-dir -r edi/requirements.txt
#RUN pip3 install --no-cache-dir -r edi/test-requirements.txt
##RUN pip3 install --no-cache-dir -r edi/oca_dependencies.txt
    
#RUN pip3 install --no-cache-dir pytrustnfe3 python3-cnab python3-boleto pycnab240 python-sped
#RUN pip3 install --no-cache-dir odoo14-addon-account-move-base-import
RUN pip3 install --no-cache-dir Iugu
RUN pip3 install --no-cache-dir signxml==2.9.0
RUN pip3 install --no-cache-dir pyopenssl==22.1.0
RUN pip3 install --no-cache-dir formio-data==0.4.5

## Install server-tools requirements.
#RUN pip3 install --no-cache-dir -r server-tools/requirements.txt

## Install community-data-files requirements.
#RUN pip3 install --no-cache-dir -r community-data-files/requirements.txt

## Install l10n-brazil requirements.
RUN pip3 install --no-cache-dir -r l10n-brazil/requirements.txt
RUN pip3 install --no-cache-dir -r l10n-brazil/test-requirements.txt
#RUN pip3 install --no-cache-dir -r l10n-brazil/oca_dependencies.txt


### Configuracoes Odoo
######################
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
    
## Diretorio de trabalho ODOO
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
ENV TIME_CPU=6000
ENV TIME_REAL=7200
ENV DB_FILTER=False
ENV SENTRY_DSN=False
ENV SENTRY_ENABLED=False

VOLUME ["/opt/", "/etc/odoo"]
ENTRYPOINT ["/opt/odoo/entrypoint.sh"]
CMD ["/usr/bin/supervisord"]
