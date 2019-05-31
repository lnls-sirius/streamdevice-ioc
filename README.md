# Sirius Stream Device IOCs
## Deploy
The following is a list of applications and ports:

|   Device  |Port|
|:----------|---:|
|spixconv   |5005|
|agilent4uhv|5004|
|mbtemp     |5003|
|mks937b    |5002|
|countingPRU|5000|

In order to deploy use the command:
```
docker stack deploy --compose-file docker/docker-stack.yml streamdevice-ioc
```
To check the deployment run:
```
docker service ls
```
Add the following environment variables to a service in order to launch IOCs in different ports (`docker/docker-stack.yml` ).<br>
The user must set the initial port value.

```
EPICS_CA_PORT_INCREASE=--epics-ca-port-increase
BASE_EPICS_CA_PORT=--base-epics-ca-port 5070
```

## Develop
To change the contents of the deployed service the user must built and push the new image to dockerhub. <br>
Keep in mind that commits won't affect old images as the repo is cloned when building it. <br>

To build a new image push the changes to master or add a checkout inside the Dockerfile. Run the script at `docker/build.sh` setting the correct tag name.
