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

## Push the image to docker hub

First build the image and get the image id with `docker images`.

Then rename the docker image and optionally add a specific tag:
 `docker tag d9c8d3b75749 hiorgserver/hiorgtest[:tag]`

Finally push the images to dockerhub: `docker push hiorgserver/hiorgtest[:tag]`

