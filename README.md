## Repositories

- https://github.com/mkm29/go-grpc-product-svc - Product SVC (gRPC)
- https://github.com/mkm29/go-grpc-order-svc - Order SVC (gRPC)
- https://github.com/mkm29/go-grpc-auth-svc - Authentication SVC (gRPC)
- https://github.com/mkm29/go-grpc-api-gateway - API Gateway (HTTP)

## Installation

```bash
make init
make bootstrap
make proto
```

## Running the app

```bash
# development
make server
```

## Test

### Register User

```bash
curl -X POST \
  http://localhost:8080/v1/auth/register \
  -H 'Content-Type: application/json' \
  -d '{
  "email": "mitch@murphy.com",
  "password": "password"
}'
```

This should return a `201` status code.

### Login User

```bash
curl -X POST \
  http://localhost:8080/v1/auth/login \
  -H 'Content-Type: application/json' \
  -d '{
  "email": "mitch@murphy.com",
  "password": "password"
}'
```

This should return a payload with: 

```json
{
  "status": 200,
  "token": "eyj..."
}
```
