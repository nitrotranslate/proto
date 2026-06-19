# proto

ConnectRPC / gRPC protobuf definitions for the [Nitro](https://developer.nitrotranslate.com/)
human-translation API.

The schema under [`proto/nitrotranslate/v1/`](proto/nitrotranslate/v1/) mirrors
Nitro's production REST API 1:1:

- **Base URL:** `https://api.nitrotranslate.com/v1`
- **Auth:** HTTP Basic — API key as the username, blank password.

Each RPC carries a `google.api.http` annotation (with `response_body` where the
REST endpoint returns a naked array/object) so the services can be served over
gRPC, gRPC-Web, ConnectRPC, **and** transcoded REST simultaneously.

## Files

The API is split by domain; all files share the `nitrotranslate.v1` package.

| File | Service | RPCs |
| --- | --- | --- |
| [`common.proto`](proto/nitrotranslate/v1/common.proto) | — | shared `Resource`, `Context` |
| [`account.proto`](proto/nitrotranslate/v1/account.proto) | `AccountService` | `GetAccount` |
| [`order.proto`](proto/nitrotranslate/v1/order.proto) | `OrderService` | `ListOrders`, `GetOrder`, `DeleteOrder` |
| [`translation.proto`](proto/nitrotranslate/v1/translation.proto) | `TranslationService` | `Calculate`, `Translate` |
| [`rate.proto`](proto/nitrotranslate/v1/rate.proto) | `RateService` | `ListRates` |

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
