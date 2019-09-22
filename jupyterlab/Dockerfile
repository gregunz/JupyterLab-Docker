FROM nvidia/cuda:10.1-base-ubuntu18.04

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
RUN jupyter labextension install jupyterlab_tensorboard

## OH MY ZSH
RUN apt install -y git-core zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
COPY .zshrc ~/.zshrc
ENV SHELL=/usr/bin/zsh

## cleaning
RUN rm -rf \
      /var/lib/apt/lists/* \
      /tmp/* \
      /var/tmp/*

COPY run_jupyter.sh /tmp/run_jupyter.sh

WORKDIR /opt/app/projects
EXPOSE 8888
CMD ["/usr/bin/zsh", "/tmp/run_jupyter.sh"]
