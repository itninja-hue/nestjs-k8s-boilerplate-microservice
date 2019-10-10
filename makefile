deliver_image_to_dockerhub: build cleanup push
update_values: generate_values push_values_file
NAME   := itninjahue/box
TAG    := $$(git log -1 --pretty=%h)
IMG    := ${NAME}:${TAG}
LATEST := ${NAME}:latest
 
build:
	@docker build -t ${IMG} .
 
cleanup:
	@docker system prune -f
  
push:
	@docker push ${NAME}

generate_values:
	@helm  upgrade --set benjamin.deployment.tag=${TAG} --values helm/values.yaml microservice-benjamin helm/ --tiller-namespace box-dev --namespace box-dev --reuse-values --dry-run --debug >helm/values.tmp
	@sed -n '/COMPUTED VALUES:/,/HOOKS:/p' helm/values.tmp | tail +2 | head -n -2 >helm/values.yaml
	@rm helm/values.tmp

push_values_file:
	@git add helm/values.yaml
	@git commit -m "jenkins file [skip ci]"
	@git push

deploy:
	@helm upgrade --values helm/values.yaml microservice-benjamin helm/ --tiller-namespace box-dev --namespace box-dev --reuse-values