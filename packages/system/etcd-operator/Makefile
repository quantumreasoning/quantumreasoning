export NAME=etcd-operator
export NAMESPACE=quantum-${NAME}

include ../../../scripts/package.mk

update:
	rm -rf charts
	helm pull oci://ghcr.io/aenix-io/charts/etcd-operator --untar --untardir charts
