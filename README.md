# Kubernetes-nestjs-microservice-application-boilerplate
kubernetes application boilerplate for https://github.com/0xb4lamx/nestjs-boilerplate-microservice .

## Getting Started

These instructions will get you a copy of the project up and running on your kubernetes cluster.

### Prerequisites
* Tiller deployed on the kubernetes cluster.
* Ingress controller (Nginx,Traefik..).
* Storage Class.
* ssh connection to git.

## Installation

### Environment Setup

In Values.yaml:

* Configure needed secrets for:
    * MYSQL Database.
    * Eventstore.
    * Credentials for private dockerhub.
* create needed namespaces. for this example you can type:
```shell
kubectl create ns dev-microservice-template
kubectl create ns preprod-microservice-template
kubectl create ns prod-microservice-template
```

### Deployment
#### ArgoCD

If using ArgoCD apply argocd yaml files representing each an environment.
```shell
kubectl apply -f argo-cd-dev.yaml
```
 
#### helm3

```shell

helm  install  dev/ dev-microservice-boilerplate --namespace dev-microservice-template --name dev-microservice-template

```

### Description
This kuberntes application will deploy:
* MySQL deployment.
* Expose MySQL as A clusterIp Service.
* Expose EventStore Gui as Ingress.
* Microservice deployment.
* Expose Microservice as Ingress.
* It supports out of the box multi development environement deployment [dev,preprod,prod] following the follwoing naming convention: 
    * production environement namespace strictly start with prod.
    * development environement namespace strictly start with dev.
    * preprod environement namespace strictly start with preprod.
