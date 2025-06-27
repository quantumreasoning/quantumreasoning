FROM golang:1.24-alpine AS builder

ARG TARGETOS
ARG TARGETARCH

WORKDIR /workspace

COPY go.mod go.sum ./
RUN GOOS=linux GOARCH=amd64 go mod download

COPY api api/
COPY pkg pkg/
COPY cmd cmd/
COPY internal internal/

RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -ldflags="-extldflags=-static" -o /quantumreasoning-controller cmd/quantumreasoning-controller/main.go

FROM scratch

COPY --from=builder /quantumreasoning-controller /quantumreasoning-controller
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

ENTRYPOINT ["/quantumreasoning-controller"]
