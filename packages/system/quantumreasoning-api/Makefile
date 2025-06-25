NAME=quantumreasoning-api
NAMESPACE=quantum-system

include ../../../scripts/common-envs.mk
include ../../../scripts/package.mk

image: image-quantumreasoning-api

image-quantumreasoning-api:
	docker buildx build -f images/quantumreasoning-api/Dockerfile ../../.. \
		--provenance false \
		--builder=$(BUILDER) \
		--platform=linux/amd64 \
		--tag $(REGISTRY)/quantumreasoning-api:$(call settag,$(TAG)) \
		--cache-from type=registry,ref=$(REGISTRY)/quantumreasoning-api:latest \
		--cache-to type=inline \
		--metadata-file images/quantumreasoning-api.json \
		--push=$(PUSH) \
		--label "org.opencontainers.image.source=https://github.com/quantumreasoning/quantumreasoning" \
		--load=$(LOAD)
	IMAGE="$(REGISTRY)/quantumreasoning-api:$(call settag,$(TAG))@$$(yq e '."containerimage.digest"' images/quantumreasoning-api.json -o json -r)" \
		yq -i '.quantumreasoningAPI.image = strenv(IMAGE)' values.yaml
	rm -f images/quantumreasoning-api.json
