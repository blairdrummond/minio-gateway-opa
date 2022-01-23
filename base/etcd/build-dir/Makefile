manifest.yaml: kustomization.yaml charts
	kustomize build . \
		--load-restrictor LoadRestrictionsNone \
		--enable-helm > $@


