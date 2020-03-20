#######################################################################################
# Docker image for Backoffice Project
########################################################################################
# Installation details
#######################################################################################

FROM dockerrepository.pics.unisys/unisys/jboss_framework:1

# Configure JBoss resources
COPY configs/* /tmp/
RUN chmod 755 /tmp/*

# Reduz a memoria do JBoss
RUN sed -i.bak 's/1303m/1024m/g' ${EAP_HOME}/bin/standalone.conf

# Executa os scripts de configuracao
RUN /tmp/configure.sh && \
    rm -f /tmp/*.jar /tmp/*.cli /tmp/*.sh && \
    rm -rf ${EAP_HOME}/standalone/data/* && \
    rm -rf ${EAP_HOME}/standalone/tmp/* && \
    rm -rf ${EAP_HOME}/standalone/log/* && \
    rm -rf ${EAP_HOME}/standalone/configuration/standalone_xml_history

# Deploy
COPY ciweb-backoffice-ear/target/ciweb-backoffice-ear*.ear ${EAP_HOME}/standalone/deployments/
# COPY target/*.ear ${EAP_HOME}/standalone/deployments/

CMD []
