export NAME=gpu-operator
export NAMESPACE=quantum-$(NAME)

include ../../../scripts/common-envs.mk
include ../../../scripts/package.mk

update:
	rm -rf charts
	helm repo add nvidia https://helm.ngc.nvidia.com/nvidia
	helm repo update nvidia
	helm pull nvidia/gpu-operator --untar --untardir charts
