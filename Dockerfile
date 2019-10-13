FROM tensorflow/tensorflow:1.14.0-gpu-py3-jupyter

LABEL mantainer="Allan Batista <allan@allanbatista.com.br>"

# no interaction
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

# Jupyter
ENV PASSWORD=password
ENV JUPYTER_HOME=/jupyter/notebook
ENV JUPYTER_CONFIG=/jupyter_notebook_config.py

# google cloud sdk
ENV PATH=$PATH:/usr/local/gcloud/google-cloud-sdk/bin
ENV CLOUDSDK_PYTHON="python2.7"
ENV GOOGLE_APPLICATION_CREDENTIALS_JSON=
ENV GOOGLE_APPLICATION_ACCOUNT=
ENV GOOGLE_APPLICATION_PROJECT=
ENV CLOUD_SDK_REPO=cloud-sdk-bionic

# language
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LC_MESSAGES en_US.UTF-8

RUN mkdir $JUPYTER_HOME -p
RUN touch $JUPYTER_CONFIG

WORKDIR ${JUPYTER_HOME}

RUN apt-get update -y \
    && apt-get install -y \
                        python2.7-minimal \
                        python3-pip \
                        python3-dev \
                        python3-setuptools \
                        zip \
                        wget \
                        git \
                        vim \
                        locales \
                        build-essential \
                        curl \
                        default-libmysqlclient-dev \
                        freetds-dev \
                        libkrb5-dev \
                        libsasl2-dev \
                        libssl-dev \
                        libffi-dev \
                        libpq-dev \
                        graphviz \
                        cmake \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen \
    && apt-get clean

RUN echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && \
    apt-get install google-cloud-sdk -y

RUN pip3 install jupyter \
                 boto3 \
                 pandas \
                 numpy \
                 matplotlib \
                 sklearn \
                 psycopg2 \
                 pymongo \
                 mysql \
                 redis \
                 google-cloud-storage \
                 google-cloud-bigquery \
                 google-cloud-storage \
                 google-cloud-bigtable \
                 sasl thrift thrift-sasl PyHive \
                 pyhs2 \
                 iplotter \
                 unidecode \
                 plotly \
                 awscli \
                 pydot \
                 graphviz \
                 nltk \
                 opencv-python

RUN ln -sf $(which pip3) /usr/bin/pip \
    && ln -sf $(which python3) /usr/bin/python


RUN cd /tmp && \
    git clone https://github.com/facebookresearch/fastText.git && \
    cd fastText && \
    mkdir build && cd build && cmake .. && \
    make && make install && \
    cd ~ && rm -Rf /tmp/fastText


EXPOSE 8888

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD ["/entrypoint.sh", "notebook"]
