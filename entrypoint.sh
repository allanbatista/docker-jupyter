#!/bin/bash

if [ -n "$PASSWORD" ]; then
  echo "c.NotebookApp.password=u'$(python -c "from notebook.auth import passwd; print(passwd('${PASSWORD}'))")'" >> $JUPYTER_CONFIG
  echo "c.NotebookApp.password_required=True" >> $JUPYTER_CONFIG
fi

jupyter notebook --notebook-dir /jupyter/notebook --port 8000 --ip 0.0.0.0 --config=$JUPYTER_CONFIG --allow-root -y