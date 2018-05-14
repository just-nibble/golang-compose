FROM golang:1.11-alpine AS builder

WORKDIR /build

COPY go.mod go.sum ./
RUN go mod download

# Build
COPY . ./
RUN CGO_ENABLED=0 go build -o app

# Create final image
FROM alpine
WORKDIR /
COPY --from=builder /build/app .
EXPOSE 8080
CMD ["./app"]
