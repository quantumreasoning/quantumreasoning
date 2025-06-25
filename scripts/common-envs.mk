REGISTRY := ghcr.io/quantumreasoning/quantumreasoning
PUSH := 1
LOAD := 0
QUANTUMREASONING_VERSION = $(patsubst v%,%,$(shell git describe --tags))
TAG = $(shell git describe --tags --exact-match 2>/dev/null || echo latest)

# Returns 'latest' if the git tag is not assigned, otherwise returns the provided value
define settag
$(if $(filter $(TAG),latest),latest,$(1))
endef

ifeq ($(QUANTUMREASONING_VERSION),)
    $(shell git remote add upstream https://github.com/quantumreasoning/quantumreasoning.git || true)
    $(shell git fetch upstream --tags)
    QUANTUMREASONING_VERSION = $(patsubst v%,%,$(shell git describe --tags))
endif

# Get the name of the selected docker buildx builder
BUILDER ?= $(shell docker buildx inspect --bootstrap | head -n2 | awk '/^Name:/{print $$NF}')
# Get platforms supported by the builder
PLATFORM ?= $(shell docker buildx ls --format=json | jq -r 'select(.Name == "$(BUILDER)") | [.Nodes[].Platforms // []] | flatten | unique | map(select(test("^linux/amd64$$|^linux/arm64$$"))) | join(",")')

