#!/bin/bash

if [ -n "$PASSWORD" ]; then
  echo "c.NotebookApp.password=u'$(python -c "from notebook.auth import passwd; print(passwd('${PASSWORD}'))")'" >> $JUPYTER_CONFIG
  echo "c.NotebookApp.password_required=True" >> $JUPYTER_CONFIG
fi

if [-n "$GOOGLE_APPLICATION_CREDENTIALS_JSON"]; then
  export GOOGLE_APPLICATION_CREDENTIALS=/root/google_key.json
  echo $GOOGLE_APPLICATION_CREDENTIALS_JSON > $GOOGLE_APPLICATION_CREDENTIALS

  if [-n "$GOOGLE_APPLICATION_ACCOUNT"]; then
    gcloud auth activate-service-account --account $GOOGLE_APPLICATION_ACCOUNT --key-file=$GOOGLE_APPLICATION_CREDENTIALS
  fi
fi

if [ $1 == "notebook" ]; then
  jupyter notebook --notebook-dir $JUPYTER_HOME --port 8888 --ip 0.0.0.0 --config=$JUPYTER_CONFIG --allow-root -y
else
  exec $@
fi
