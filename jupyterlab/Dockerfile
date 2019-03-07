FROM python:3.6-slim

LABEL maintainer="gregunz <contact@gregunz.io>"
ENV LANG=C.UTF-8

## installing dependencies
COPY apt_packages.txt /tmp/apt_packages.txt
RUN apt-get update && \
    xargs -a /tmp/apt_packages.txt apt-get install -y

## cleaning app manager and updating pip
RUN apt-get clean && \
    apt-get autoremove && \
    pip3 install --upgrade pip

## installing numpy (otherwise an error occurs)
RUN pip3 --no-cache-dir install numpy

## installing all pip libraries
COPY pip_libraries.txt /tmp/pip_libraries.txt
RUN pip3 --no-cache-dir install --upgrade -r /tmp/pip_libraries.txt

## installing NodeJS
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs

## jupyterlab widgets
RUN jupyter nbextension enable --py widgetsnbextension
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager
RUN jupyter labextension install @jupyterlab/toc

## pybox2d (https://github.com/pybox2d/pybox2d/blob/master/INSTALL.md)
RUN git clone https://github.com/pybox2d/pybox2d && \
    cd pybox2d && \
    python3 setup.py install && \
    cd .. && \
    rm -rf pybox2d

##  python3-midi
RUN git clone https://github.com/louisabraham/python3-midi && \
    cd python3-midi && \
    python3 setup.py install && \
    cd .. && \
    rm -rf python3-midi

## cleaning
RUN rm -rf \
      /var/lib/apt/lists/* \
      /tmp/* \
      /var/tmp/*

COPY run_jupyter.sh /tmp/run_jupyter.sh

WORKDIR /opt/app/projects
EXPOSE 8888
CMD ["/bin/bash", "/tmp/run_jupyter.sh"]