export NAME=piraeus-operator
export NAMESPACE=quantum-linstor

include ../../../scripts/package.mk

update:
	rm -rf charts
	tag=$$(git ls-remote --tags --sort="v:refname" https://github.com/piraeusdatastore/piraeus-operator  | awk -F'[/^]' 'END{print $$3}') && \
	curl -sSL https://github.com/piraeusdatastore/piraeus-operator/archive/refs/tags/$${tag}.tar.gz | \
	tar xzvf - --strip 1 piraeus-operator-$${tag#*v}/charts
