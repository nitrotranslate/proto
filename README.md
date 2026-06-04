# proto

ConnectRPC / gRPC protobuf definitions for the [Nitro](https://developer.nitrotranslate.com/)
human-translation API.

The schema in [`proto/nitro/v1/nitro.proto`](proto/nitro/v1/nitro.proto) mirrors
Nitro's production REST API 1:1:

- **Base URL:** `https://api.nitrotranslate.com/v1`
- **Auth:** HTTP Basic — API key as the username, blank password.

Each RPC carries a `google.api.http` annotation (with `response_body` where the
REST endpoint returns a naked array/object) so the service can be served over
gRPC, gRPC-Web, ConnectRPC, **and** transcoded REST simultaneously.

## Service methods

| RPC | REST route | Notes |
| --- | --- | --- |
| `GetAccount` | `GET /v1/account` | Balance and reserved funds |
| `ListOrders` | `GET /v1/orders` | `sort`, `page`, `per_page` query params |
| `GetOrder` | `GET /v1/orders/{id}` | Full order detail |
| `DeleteOrder` | `DELETE /v1/orders/{id}` | QUEUE status only |
| `Calculate` | `POST /v1/calculate` | Cost estimate per target language |
| `Translate` | `POST /v1/translate` | Submit content, create orders |
| `ListRates` | `GET /v1/rates` | Current per-pair pricing |

## Conventions

- **Enums as strings.** Enum-like fields (`status`, `tone`, `category`, comment
  `role`, language codes) are modeled as `string` constrained with
  [protovalidate](https://buf.build/bufbuild/protovalidate) `string.in` rather
  than proto enums, so the JSON wire format matches production exactly
  (`"QUEUE"`, `"GUESS"`, `"GAMES"`, …) instead of the prefixed names proto enum
  JSON would emit.
- **Validation.** Request constraints (required fields, language sets,
  pagination bounds) are expressed with `buf.validate.field` options.

## Working with the schema

```sh
buf dep update   # fetch googleapis + protovalidate
buf build        # compile
buf lint         # lint
```
