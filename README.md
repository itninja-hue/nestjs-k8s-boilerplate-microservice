# nestjs-k8s-boilerplate-microservice
kubernetes microserviceapplication  boilerplate based on Nest, a framework TypeScript.

## Getting Started

These instructions will get you a copy of the project up and running on yout kubernetes cluster.

### Prerequisites
* Tiller deployed on the kubernetes cluster
* Ingress controller (Nginx,Traefik..)
* Storage Class

## Installation

### Environment Setup

* Configure and deploy needed secrets for:
    * MYSQL Database.
    * Eventstore.
    * Credentials for private dockerhub.
* Configure and deploy needed namespace.
* Edit as you see fit default values at helm/values.yaml .

### Deployment
 
```shell

helm  install  helm/ --tiller-namespace box-dev --namespace box-dev --name microservice-benjamin

```

### Description
This kuberntes application will deploy:
* MySQL deployment.
* Expose MySQL as A clusterIp Service.
* Eventstore deployment. 
* Expose store as A clusterIp Service.
* Expose EventStore Gui as Ingress.
* Microservice deployment.
* Expose Microservice as Ingress.