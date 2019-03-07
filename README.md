# Sirius Stream Device IOCs
## Deploy
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
