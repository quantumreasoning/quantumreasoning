export NAME=kubevirt-cdi-operator
export NAMESPACE=quantum-kubevirt-cdi

include ../../../scripts/package.mk

update:
	rm -rf templates
	mkdir templates
	export VERSION=$$(basename $$(curl -s -w %{redirect_url} https://github.com/kubevirt/containerized-data-importer/releases/latest)) && \
	wget https://github.com/kubevirt/containerized-data-importer/releases/download/$$VERSION/cdi-operator.yaml -O templates/cdi-operator.yaml
	sed -i 's/namespace: cdi/namespace: quantum-kubevirt-cdi/g' templates/cdi-operator.yaml
	awk -i inplace -v RS="---" '!/kind: Namespace/{printf "%s", $$0 RS}' templates/cdi-operator.yaml
