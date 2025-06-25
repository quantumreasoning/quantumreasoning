FROM golang:1.24-alpine AS builder

ARG TARGETOS
ARG TARGETARCH

WORKDIR /workspace

COPY go.mod go.sum ./
RUN GOOS=$TARGETOS GOARCH=$TARGETARCH go mod download

COPY api api/
COPY pkg pkg/
COPY cmd cmd/
COPY internal internal/

RUN GOOS=$TARGETOS GOARCH=$TARGETARCH CGO_ENABLED=0 go build -ldflags="-extldflags=-static" -o /quantumreasoning-api cmd/quantumreasoning-api/main.go

FROM scratch

COPY --from=builder /quantumreasoning-api /quantumreasoning-api

ENTRYPOINT ["/quantumreasoning-api"]
