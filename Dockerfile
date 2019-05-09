FROM python:3-slim-jessie

LABEL mantainer="Allan Batista <allan@allanbatista.com.br>"

ENV PASSWORD=password
ENV JUPYTER_CONFIG=/jupyter_notebook_config.py
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

RUN mkdir /jupyter/notebook -p
RUN touch $JUPYTER_CONFIG

RUN pip install jupyter==1.0.0

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

CMD ["notebook"]
