FROM golang:1.24-alpine as k8s-await-election-builder

ARG K8S_AWAIT_ELECTION_GITREPO=https://github.com/LINBIT/k8s-await-election
ARG K8S_AWAIT_ELECTION_VERSION=0.4.1

# TARGETARCH is a docker special variable: https://docs.docker.com/engine/reference/builder/#automatic-platform-args-in-the-global-scope
ARG TARGETARCH

RUN apk add --no-cache git make
RUN git clone ${K8S_AWAIT_ELECTION_GITREPO} /usr/local/go/k8s-await-election/ \
 && cd /usr/local/go/k8s-await-election \
 && git reset --hard v${K8S_AWAIT_ELECTION_VERSION} \
 && make \
 && mv ./out/k8s-await-election-${TARGETARCH} /k8s-await-election

FROM golang:1.24-alpine as builder

ARG TARGETOS
ARG TARGETARCH

RUN apk add --no-cache make git
RUN apk add helm --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community

COPY . /src/
WORKDIR /src

RUN go mod download

RUN go build -o /quantumreasoning-assets-server -ldflags '-extldflags "-static" -w -s' ./cmd/quantumreasoning-assets-server

# RUN make repos
RUN make repos || (echo "Make failed"; cat Makefile; exit 1)

FROM alpine:3.22

RUN wget -O- https://github.com/quantumreasoning/quantumpkg/raw/refs/heads/main/hack/install.sh | sh 

RUN apk add --no-cache make kubectl coreutils

COPY --from=builder /src/scripts /quantumreasoning/scripts
COPY --from=builder /src/packages/core /quantumreasoning/packages/core
COPY --from=builder /src/packages/system /quantumreasoning/packages/system
COPY --from=builder /src/_out/repos /quantumreasoning/assets/repos
# COPY --from=builder /src/_out/logos /quantumreasoning/assets/logos
COPY --from=builder /quantumreasoning-assets-server /usr/bin/quantumreasoning-assets-server
COPY --from=k8s-await-election-builder /k8s-await-election /usr/bin/k8s-await-election
# COPY --from=builder /src/dashboards /quantumreasoning/assets/dashboards

RUN chmod +x /quantumreasoning/scripts/installer.sh

WORKDIR /quantumreasoning
ENTRYPOINT ["/usr/bin/k8s-await-election", "/quantumreasoning/scripts/installer.sh" ]
