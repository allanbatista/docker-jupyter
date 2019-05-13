# Simple Jupyter Docker

This container image is simple and easy to use. 

* python3
* jupyter
* gcloud sdk
* repository: https://github.com/allanbatista/docker-jupyter

## ENV VAR

    PASSWORD=password

### authentication google cloud sdk

is need to be set up all this variables to work fine. use service account

    GOOGLE_APPLICATION_CREDENTIALS_JSON={...}
    GOOGLE_APPLICATION_PROJECT=project-id
    GOOGLE_APPLICATION_ACCOUNT=account-name@like.email

This will be generate other env var with path wherer service account will be storage

    GOOGLE_APPLICATION_CREDENTIALS

## Execute

    $ docker run --rm -p 8888:8888 -e PASSWORD=my_password allanbatista/jupyter notebook

**data dir**

    /jupyter/notebook jupyter home
    /root admin home
