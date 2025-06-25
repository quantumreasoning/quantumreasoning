NAME=quantum-proxy
NAMESPACE=quantum-system

include ../../../scripts/common-envs.mk
include ../../../scripts/package.mk

update:
	rm -rf charts
	tag=$$(git ls-remote --tags --sort="v:refname" https://github.com/quantumreasoning/quantum-proxy | awk -F'[/^]' 'END{print $$3}') && \
	curl -sSL https://github.com/quantumreasoning/quantum-proxy/archive/refs/tags/$${tag}.tar.gz | \
	tar xzvf - --strip 1 quantum-proxy-$${tag#*v}/charts
