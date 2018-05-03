FROM ubuntu:16.04 as ubuntu-build

ENV PATH /usr/local/anaconda2/bin:$PATH

RUN set -x \
	  && apt-get update \
	  && apt-get install -y \
    libpng-dev \
    libssl-dev \
    libcurl4-openssl-dev \
	  zlib1g-dev \
	  libfreeimage-dev \
    cmake \
    gcc \
    g++ \
    apache2-dev \
    apache2 \
    swig \ 
    gobjc++ \
    git \
    libcurl3 \
    curl \
    dos2unix

RUN apt-get install -y \
    wget \
    bzip2 \
    ca-certificates \
    libglib2.0-0 

RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda2-4.4.10-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /usr/local/anaconda2 && \
    rm ~/miniconda.sh && \
    conda update -n base conda && \
    conda install -c conda-forge numpy
    #ln -s /usr/local/anaconda2/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    #echo ". /usr/local/anaconda2/etc/profile.d/conda.sh" >> ~/.bashrc && \
    #echo "conda activate base" >> ~/.bashrc

COPY visus.tar.gz /visus/visus.tar.gz

WORKDIR /visus

RUN tar xzf visus.tar.gz 

WORKDIR build

RUN cmake ../ \
    -DCMAKE_BUILD_TYPE=Release \
    -DVISUS_GUI=0 \
	  -DVISUS_INTERNAL_PYTHON=0 \    
    -DVISUS_DEFAULT_CONFIG_FILE="/visus/config/visus.config" \
    -DVISUS_SERVER_CONFIG_FILE=/visus/config/server.config \
    -DAPACHE_INCLUDE_DIR=/usr/include/apache2 \
    -DPYTHON_EXECUTABLE=`which python` \
    -DPYTHON_LIBRARY=/usr/local/anaconda2/lib/libpython2.7.so \
    -DPYTHON_INCLUDE_DIR=/usr/local/anaconda2/include/python2.7 \
    -DVISUS_CACHE_PATH=/visus/cache \
    -DVISUS_LOG_FILE=/visus/visus.log \
    -DCMAKE_INSTALL_PREFIX=/usr/local/visus
    
RUN make -j4
  
RUN make install

FROM ubuntu:16.04 

COPY --from=ubuntu-build /usr/local/visus /usr/local/visus

ENV PATH /usr/local/anaconda2/bin:$PATH
ENV PYTHONPATH /usr/local/visus/:$PYTHONPATH
ENV LD_LIBRARY_PATH /usr/local/anaconda2/lib/:$LD_LIBRARY_PATH

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    libpng-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libfreeimage-dev \
    libcurl3 \
    curl \
    apache2 \
    unzip \ 
    wget \
    bzip2 \
    ca-certificates \
    libglib2.0-0

RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda2-4.4.10-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /usr/local/anaconda2 && \
    rm ~/miniconda.sh && \
    conda update -n base conda && \
    conda install -c conda-forge numpy && \
    apt-get clean

RUN  mkdir -p /var/www/visus && \
     cd /var/www/visus && \
     curl --remote-name --time-cond cacert.pem https://curl.haxx.se/ca/cacert.pem && \
     chown -R www-data .

ADD  envvars              /etc/apache2/
ADD  visus.load           /etc/apache2/mods-available/
RUN  rm                   /etc/apache2/sites-enabled/000-default.conf
ADD  visus_config         /visus/config
ADD  visus_datasets       /visus/datasets
ADD  apache2.tgz          /visus/
RUN  chown -R www-data    /visus
ADD  start_server.sh      /visus

RUN  cd /etc/apache2 \
     && sed -i "s#Include ports.conf#Include /tmp/apache2/ports.conf#" apache2.conf \
     && echo "IncludeOptional /tmp/apache2/sites-enabled/*.conf" >> apache2.conf \
     && cd /visus \
     && chmod u+x start_server.sh \
     && curl https://codeload.github.com/sci-visus/visus_javascript/zip/master -o master.zip \
     && unzip master.zip \
     && rm master.zip \
     && mv visus_javascript-master webviewer

RUN chmod a+x /usr/local/visus/*.so \
  && chown www-data /visus \
  && chmod -R a+rX  /visus \
  && rm -r /var/lib/apt/lists/*

RUN a2enmod headers
RUN a2enmod visus

WORKDIR /usr/local/visus
RUN python setup.py install

WORKDIR /visus

EXPOSE 80
CMD ["/visus/start_server.sh"]