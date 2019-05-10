# Simple Jupyter Docker

This container image is simple and easy to use. 

* python3
* jupyter==1.0.0
* gcloud sdk
* repository: https://github.com/allanbatista/docker-jupyter

## ENV VAR

    PASSWORD=password

### authentication google cloud sdk

    GOOGLE_CLOUD_SDK_KEY_JSON
    GOOGLE_APPLICATION_ACCOUNT

## Execute

    $ docker run --rm -p 8888:8888 -e PASSWORD=my_password allanbatista/jupyter notebook

**data dir**

    /jupyter/notebook jupyter home
    /root admin home