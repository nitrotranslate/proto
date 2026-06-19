# NitroTranslate API

ConnectRPC / gRPC protobuf definitions for the [NitroTranslate](https://nitrotranslate.com/)
human-translation API, mirroring Nitro's production REST API 1:1.

`AccountService`, `OrderService`, `TranslationService` and `RateService` under
`nitrotranslate/v1`, each annotated for gRPC, gRPC-Web, ConnectRPC and
transcoded REST.

Add to your `buf.yaml` deps and run `buf generate`:

```yaml
deps:
  - buf.build/nitrotranslate/nitro
```
