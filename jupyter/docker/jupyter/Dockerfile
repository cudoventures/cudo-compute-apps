FROM jupyter/minimal-notebook

RUN wget https://download.cudo.org/compute/cudoctl-amd64.deb
USER root
RUN dpkg -i cudoctl-amd64.deb
USER $NB_UID

COPY ./requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt