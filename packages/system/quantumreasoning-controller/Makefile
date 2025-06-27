NAME=quantumreasoning-controller
NAMESPACE=quantum-system

include ../../../scripts/common-envs.mk
include ../../../scripts/package.mk

TAG=v42.9.5

image: image-quantumreasoning-controller update-version

image-quantumreasoning-controller:
	docker buildx build -f images/quantumreasoning-controller/Dockerfile ../../.. \
		--provenance false \
		--builder=$(BUILDER) \
		--platform=linux/amd64 \
		--tag $(REGISTRY)/quantumreasoning-controller:$(call settag,$(TAG)) \
		--cache-from type=registry,ref=$(REGISTRY)/quantumreasoning-controller:latest \
		--cache-to type=inline \
		--metadata-file images/quantumreasoning-controller.json \
		--push=$(PUSH) \
		--label "org.opencontainers.image.source=https://github.com/quantumreasoning/quantumreasoning" \
		--load=$(LOAD)
	IMAGE="$(REGISTRY)/quantumreasoning-controller:$(call settag,$(TAG))@$$(yq e '."containerimage.digest"' images/quantumreasoning-controller.json -o json -r)" \
		yq -i '.quantumreasoningController.image = strenv(IMAGE)' values.yaml
	rm -f images/quantumreasoning-controller.json

update-version:
	TAG="$(call settag,$(TAG))" \
		yq -i '.quantumreasoningController.quantumreasoningVersion = strenv(TAG)' values.yaml
