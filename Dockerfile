FROM python:3-slim-jessie

MAINTAINER Allan Batista <allan@allanbatista.com.br>

ENV PASSWORD=password
ENV JUPYTER_CONFIG=/jupyter_notebook_config.py

RUN mkdir /jupyter/notebook -p
RUN touch $JUPYTER_CONFIG

RUN pip install jupyter==1.0.0

EXPOSE 8000

COPY entrypoint.sh /entrypoint.sh

CMD /bin/bash /entrypoint.sh
