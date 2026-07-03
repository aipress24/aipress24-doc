.PHONY: build serve clean deploy api-spec

# Path to the application checkout that generates the canonical OpenAPI spec.
# Override if your app repo lives elsewhere: `make api-spec APP_REPO=/path/to/aipress24`.
APP_REPO ?= ../aipress24
API_SPEC_SRC ?= $(APP_REPO)/sdk/python/openapi.json

## Default target: run the development server
all: build

## Help
help:
	adt help-make

## Refresh the published OpenAPI spec from the app repo (used by the Swagger
## reference at /dev/api-explorer/). Best-effort: if the app repo is not a
## sibling checkout, the committed snapshot is used as-is.
api-spec:
	@if [ -f "$(API_SPEC_SRC)" ]; then \
		python3 scripts/build_openapi.py "$(API_SPEC_SRC)"; \
	else \
		echo "note: $(API_SPEC_SRC) not found — using committed openapi.json snapshot"; \
	fi

## Generate documentation
build: api-spec
	# Currently not working (need to fix sqla2uml)
	# sqla2uml -p -m app > src/dev/diagrams/db/model-detailed.puml
	# sqla2uml -m app > src/dev/diagrams/db/model-simple.puml
	# plantuml src/dev/diagrams/db/*.puml
	zensical build

## Run the development server
serve:
	zensical serve

## Deploy the documentation to the server
deploy: build
	hop3 deploy --context prod -y

## Clean the build
clean:
	rm -rf site

## Alias for clean
tidy: clean
