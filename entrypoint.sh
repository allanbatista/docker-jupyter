#!/bin/bash

if [ -n "$PASSWORD" ]; then
  echo "c.NotebookApp.password=u'$(python -c "from notebook.auth import passwd; print(passwd('${PASSWORD}'))")'" >> $JUPYTER_CONFIG
  echo "c.NotebookApp.password_required=True" >> $JUPYTER_CONFIG
fi

if [ $1 == "notebook" ]; then
  jupyter notebook --notebook-dir $JUPYTER_HOME --port 8888 --ip 0.0.0.0 --config=$JUPYTER_CONFIG --allow-root -y
else
  exec $@
fi
