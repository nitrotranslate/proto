build:
    buf build --exclude-path proto/openapi.proto -o descriptor.pb

generate version="0.0.0-dev":
	buf generate
	yq -i '(.paths[] | .[] | select(tag == "!!map" and has("parameters")) | .parameters[] | select(.schema.format == "date-time")) |= (del(.description) | del(.schema.examples))' openapi.yaml
	yq -i '.info.version = "{{version}}"' openapi.yaml
