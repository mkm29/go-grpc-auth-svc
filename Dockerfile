# Multistage Go build
FROM golang:1.19.2-alpine3.16 AS builder
RUN apk add --no-cache git
WORKDIR /go/src/github.com/mkm29/auth-svc/
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix nocgo -o /app ./cmd/main.go

# Final image
FROM alpine:3.16
LABEL maintainer="Mitch Murphy <mitch.murphy@gmail.com>" \
  version="0.1.1" \
  description="Auth service for Go gRPC demo"
ARG DB_HOST="db"
ARG DB_PORT="5432"
ARG DB_DATABASE="auth_svc"
ARG DB_USERNAME
ARG DB_PASSWORD
COPY --from=builder /app /auth-svc/
COPY --from=builder /go/src/github.com/mkm29/auth-svc/pkg/config/envs/ /auth-svc/
ENV DB_HOST=$DB_HOST \
  DB_PORT=$DB_PORT \
  DB_USERNAME=$DB_USERNAME \
  DB_PASSWORD=$DB_PASSWORD \
  DB_DATABASE=$DB_DATABASE
EXPOSE 50051
ENTRYPOINT ["/auth-svc/app"]