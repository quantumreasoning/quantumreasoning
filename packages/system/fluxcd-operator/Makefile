NAME=fluxcd-operator
NAMESPACE=quantum-fluxcd

include ../../../scripts/package.mk

apply-locally:
	quantumpkg apply --plain -n $(NAMESPACE) $(NAME)

update:
	rm -rf charts
	helm pull oci://ghcr.io/controlplaneio-fluxcd/charts/flux-operator --untar --untardir charts
	patch --no-backup-if-mismatch -p1 < patches/kubernetesEnvs.diff
