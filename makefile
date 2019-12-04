update_values: generate_values push_values_file
deploy_to_cluster: deploy
microserviceName := microservice-boilerplate

generate_values:
	@helm  upgrade --set microservice.deployment.tag=${TAG} --set general.namespace=${namespace} --values helm/values.yaml ${microserviceName} helm/ --tiller-namespace ${namespace} --namespace ${namespace} --reuse-values --dry-run --debug >helm/values.tmp
	@sed -n '/COMPUTED VALUES:/,/HOOKS:/p' helm/values.tmp | tail -n +2 | head -n -2 >helm/values.yaml
	@rm helm/values.tmp

push_values_file:
	@git add helm/values.yaml
	@git commit -m "Values update"
	@git push

deploy:
	@helm upgrade --values helm/values.yaml ${microserviceName} helm/ --tiller-namespace ${namespace} --namespace ${namespace} --reuse-values