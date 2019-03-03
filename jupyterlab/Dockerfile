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

## setting up jupyter and jupyterlab
RUN pip3 --no-cache-dir install jupyter ipywidgets
RUN jupyter nbextension enable --py widgetsnbextension
RUN pip3 --no-cache-dir install jupyterlab && jupyter serverextension enable --py jupyterlab

## installing all pip libraries
COPY pip_libraries.txt /tmp/pip_libraries.txt
RUN pip3 --no-cache-dir install --upgrade -r /tmp/pip_libraries.txt

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

## jupyterlab extension (table of content)
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs
RUN jupyter labextension install @jupyterlab/toc

## cleaning
RUN rm -rf \
      /var/lib/apt/lists/* \
      /tmp/* \
      /var/tmp/*

WORKDIR /opt/app/projects
EXPOSE 8888
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir=/opt/app/projects --allow-root
