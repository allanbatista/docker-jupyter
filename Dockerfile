FROM ubuntu:18.04

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
ENV GOOGLE_APPLICATION_CREDENTIALS_JSON=
ENV GOOGLE_APPLICATION_ACCOUNT=

# language
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LC_MESSAGES en_US.UTF-8

RUN mkdir $JUPYTER_HOME -p
RUN touch $JUPYTER_CONFIG

RUN apt-get update \
    && apt-get install -y \
                        python \
                        python3 \
                        python-pip \
                        python3-pip \
                        python-dev \
                        python3-dev \
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
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen \
    && apt-get clean

RUN pip install jupyter \
                boto3 \
                pandas \
                numpy \
                matplotlib \
                sklearn \
                tensorflow \
                psycopg2

RUN pip3 install boto3 \
                 pandas \
                 numpy \
                 matplotlib \
                 sklearn \
                 tensorflow \
                 psycopg2

# Installing the package
COPY google-cloud-sdk-240.0.0-linux-x86_64.tar.gz /tmp
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xf /tmp/google-cloud-sdk-240.0.0-linux-x86_64.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh \
  && rm /tmp/google-cloud-sdk-240.0.0-linux-x86_64.tar.gz \
  && gcloud components update --quiet

EXPOSE 8888

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD ["/entrypoint.sh", "notebook"]
