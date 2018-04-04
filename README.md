# hiorgtest
Docker container to run tests in php/mysql environment

## Run the container

You can fetch the image from [dockerhub](https://hub.docker.com/r/hiorgserver/hiorgtest/) and run the container with:

    docker run -it --rm hiorgserver/hiorgtest /bin/sh

## Build container locally

First clone this repository:

    git clone https://github.com/hiorgserver/hiorgtest
    cd hiorgtest
  
Then build the docker image (we name it `hiorgtest`):

    docker build -t hiorgtest .

Then you can run the container:

    docker run -it --rm hiorgtest /bin/sh
