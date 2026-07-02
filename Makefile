.PHONY: build serve clean deploy

## Default target: run the development server
all: build

## Help
help:
	adt help-make

## Generate documentation
build:
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
	rsync -e ssh -avz site/ doc.aipress24.com:doc.aipress24.com/

## Clean the build
clean:
	rm -rf site

## Alias for clean
tidy: clean
