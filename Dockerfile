FROM ubuntu:20.04

# Install apt-based dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
    build-essential \
    cpanminus \
    git \
    wget

# Install latest CMake
RUN apt-get remove --purge --auto-remove cmake
WORKDIR /setup
RUN wget -q -O cmake-linux.sh https://github.com/Kitware/CMake/releases/download/v3.23.1/cmake-3.23.1-linux-x86_64.sh
RUN sh cmake-linux.sh -- --skip-license --prefix=/usr/local
WORKDIR /

# Install latexindent
RUN git clone https://github.com/cmhughes/latexindent.pl.git
WORKDIR /latexindent.pl
RUN cd helper-scripts; echo "Y" | perl latexindent-module-installer.pl; cd -
RUN mkdir build; cd build; cmake ../path-helper-files; make install
RUN ln -s /usr/local/bin/latexindent.pl /usr/local/bin/latexindent
WORKDIR /
