# kubernetes-deployer  
This image is designed to contain bare minimum packages required to deploy
services to a kubernetes cluster that is accessible only through SSTP VPN.  
## Notable Packages  
* gnupg - installed through a package manager from the official repository.  
* kubectl (v1.18.6) - downloaded from the official kubernetes storage drive. Installed
locally at /usr/local/bin/kubectl  
* helm (v3.3.0-rc.2) - downloaded from the official helm storage drive. Installed locally at
/usr/local/bin/helm  
* sstp-client - built from the source. Not a binary, but rather a plugin
of ppp package.  
* ppp-pppoe - installed through package manager from the official repository.
Contains ppp package required to run sstp-client.  
* docker-cli - installed through package manager from the official repository.  
## How to connect to SSTP server?  
Explained at [SSTP client's repository](https://github.com/sigma4vasa/sstp-client).  
## How to access host's docker through docker-cli:  
Docker running on the host's side can be accessed directly from this image by
assigning docker's socket through a volume, like so:  
```
docker run -it -v "/var/run/docker.sock:/var/run/docker.sock:rw" hub4sigma/kubernetes-deployer:latest
```