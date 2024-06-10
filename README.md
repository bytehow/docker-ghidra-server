<p align="center">
  <a href="https://hub.docker.com/r/bytehow/ghidra-server"><h3 align="center">docker-ghidra-server</h3></a>
  <p align="center">Ghidra Server Docker Image</p>

## Why?

Standing up a Ghidra Server in the cloud is a pain. It doesn't have to be. If you're new to Ghidra Server, [this primer](https://byte.how/posts/collaborative-reverse-engineering/) is a good introduction.

## Images

```bash
bytehow/ghidra-server   latest
bytehow/ghidra-server   11.0.3
bytehow/ghidra-server   10.3
bytehow/ghidra-server   10.2.2
bytehow/ghidra-server   10.1.5
bytehow/ghidra-server   9.2      
bytehow/ghidra-server   9.1.2    
```

If you'd like to use the latest from [Ghidra's master branch](https://github.com/NationalSecurityAgency/ghidra), build an image using `Dockerfile.beta`.

## Getting Started

Start the server and connect to port 13100 with a Ghidra client that has a **matching** version. All users will be created as admins and will have initial password `changeme`, which Ghidra will require you to change after you login.



### Public Server

```bash
docker run -it --rm \
    --name ghidra-server \
    -e GHIDRA_USERS="admin bytehow" \
    -v /path/to/repos:/repos \
    -p 13100-13102:13100-13102 \
    bytehow/ghidra-server
```

### Local-only Server

```bash
docker run -it --rm \
    --name ghidra-server \
    -e GHIDRA_USERS="admin bytehow" \
    -e GHIDRA_PUBLIC_HOSTNAME="0.0.0.0" \
    -v /path/to/repos:/repos \
    -p 13100-13102:13100-13102 \
    bytehow/ghidra-server
```


## Environment Variables

| Name | Description | Required | Default |
| - | - | - | - |
|`GHIDRA_USERS` | Space seperated list of users to create | No | `admin` |
|`GHIDRA_PUBLIC_HOSTNAME` | IP or hostname that remote users will use to connect to server. Set to `0.0.0.0` if hosting locally. If not set, it will try to discover your public ip by querying OpenDNS | No | Your public IP | 
| GHIDRA_SERVER_CONF | Path to a custom Ghidra server.conf | No | Use server.conf provided by the container |

## Additional information

Additional information such as capacity planning and other server configuration aspects can be found by consulting the server documentation provided at `/<GhidraInstallDir>/server/svrREADME.html`


## Issues

Find a bug? Want more features? Find something missing in the documentation? Let me know! Please don't hesitate to [file an issue](https://github.com/bytehow/docker-ghidra-server/issues/new)

## Credits

- NSA Research Directorate [https://www.ghidra-sre.org/](https://www.ghidra-sre.org/)
- blacktop's [docker-ghidra](https://github.com/blacktop/ghidra-server) project

### License

Apache License (Version 2.0)
