FROM python:3.7-slim

MAINTAINER "gregunz <contact@gregunz.io>"
ENV LANG=C.UTF-8

COPY apt_packages.txt /tmp/apt_packages.txt
RUN apt-get update && \
    xargs -a /tmp/apt_packages.txt apt-get install -y

RUN apt-get install -y --no-install-recommends \
      swig \
      xvfb \
      python-pygame \
      python-opengl

RUN apt-get clean && \
    apt-get autoremove && \
    pip3 install --upgrade pip

RUN pip3 --no-cache-dir install jupyter
RUN pip3 --no-cache-dir install ipywidgets
RUN jupyter nbextension enable --py widgetsnbextension
RUN pip3 --no-cache-dir install jupyterlab && jupyter serverextension enable --py jupyterlab

RUN pip install \
      cython \
      numpy \
      scipy \
      h5py \
      Pillow

COPY pip_libraries.txt /tmp/pip_libraries.txt
RUN pip3 --no-cache-dir install --upgrade -r /tmp/pip_libraries.txt

# As of 2018.11.26, tensorflow is still not compatible with version 3.7 (https://github.com/tensorflow/tensorflow/issues/20444)
RUN pip --no-cache-dir install --upgrade https://storage.googleapis.com/tensorflow/mac/cpu/tensorflow-0.12.0-py3-none-any.whl

RUN rm -rf /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/*

RUN git clone https://github.com/pybox2d/pybox2d && \
    cd pybox2d && \
    python3 setup.py install && \
    cd .. && \
    rm -rf pybox2d

RUN git clone https://github.com/louisabraham/python3-midi && \
    cd python3-midi && \
    python3 setup.py install && \
    cd .. && \
    rm -rf python3-midi

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs
RUN jupyter labextension install @jupyterlab/toc

WORKDIR /opt/app/projects
EXPOSE 8888
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir=/opt/app/projects --allow-root
