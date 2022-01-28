helm-manifest.yaml: values.yaml
	helm repo add bitnami https://charts.bitnami.com/charts/ || true
	helm template minio-gateway-etcd bitnami/etcd \
		-f values.yaml \
		-n minio \
		--version 6.13.2

manifest.yaml: kustomization.yaml charts
	kustomize build . \
		--load-restrictor LoadRestrictionsNone \
		--enable-helm > $@


