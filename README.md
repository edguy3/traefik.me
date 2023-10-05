# Use https://traefik.me SSL certificates for local HTTPS without having to touch your /etc/hosts or your certificate CA.

## Introduction

In my various dev cycles and continuing activities,  I run many servers on docker containers. This repo takes
Michael Pyrou's traefik.me (http://traefik.me/) and creates a docker container set that provides http and https servers with valid certificates.

The files were taken from his Gist at https://gist.github.com/pyrou/4f555cd55677331c742742ee6007a73a

Once running, you can connect to the dashboard at https://traefik.traefik.me/dashboard/#/

## Deploying

Clone the repository:
```
    git clone git@github.com:edguy3/traefik.me.git
```

Start up to start the service and get the certificates.
```
    docker-compose up -d && docker-compose logs -f
```

The process will likely fail the first time as the certificates were not available, so control-c and restart it.
```
    docker-compose down && docker-compose up -d && docker-compose logs -f
```


1. Open https://app1.traefik.me/ in your browser.
2. Then open http://app1.traefik.me/ and
3. https://traefik.traefik.me to confirm both app instances are reachable.


You'll probably want to edit out app2
```
  app2:
    image: containous/whoami
    labels:
      - "traefik.http.routers.app1.rule=Host(`app2.traefik.me`)"
```

In your application docker-compose.yaml file and add something like this to your
file.  ( or the `docker-compose.override.yml`  file.)

```
  my_local_app:
    labels:
      - "traefik.http.routers.app1.rule=Host(`amazing.traefik.me`)"
```
The my_local_app service is now exposed at https://amazing.traefik.me .


## Notes
The log will show an error like this one, haven't figured out how to silence it.

```
traefikme-traefik-1                     | time="2023-10-05T21:21:57Z" level=error msg="error while parsing rule Host(traefik.traefik.me): traefik.traefik.me is not defined" entryPointName=traefik routerName=traefik@docker
```


## Author

Original version: Michael Pyrou

Ed Guy, edguy@eguy.org adapted gist into repo
