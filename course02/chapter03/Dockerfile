FROM ubuntu

# Always executes , can be overridden by --entrypoint, CMD is passed to entrypoint as argument

ENTRYPOINT ["echo","Hello,"] 
CMD ["Najim"]

# docker build -t ubuntu-echoer .   
# docker container run ubuntu-echoer Md Najim Ahmed - Here Md Najim Ahmed is passed to the entry point. 
# docker container run ubuntu-echoer - Here nothing is passed, so it takes CMD agrugment mentioned in this file as default. Merges ENTRYPOINT and CMD

# docker login
# cd course02/chapter03
# docker image build . -t ubuntu-echoer
# docker image tag ubuntu-echoer ivplay4689/ubuntu-echoer
# docker image push ivplay4689/ubuntu-echoer