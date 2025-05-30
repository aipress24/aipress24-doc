.PHONY: build serve clean deploy pdf

## Default target: run the development server
all: serve

## Help
help:
	adt help-make

## Generate documentation
build:
	# Currently not working (need to fix sqla2uml)
	# sqla2uml -p -m app > src/dev/diagrams/db/model-detailed.puml
	# sqla2uml -m app > src/dev/diagrams/db/model-simple.puml
	# plantuml src/dev/diagrams/db/*.puml
	mkdocs build

## Run the development server
serve:
	mkdocs serve

## Deploy the documentation to the server
deploy: build
	rsync -e ssh -avz site/ doc.aipress24.com:doc.aipress24.com/

## Clean the build
clean:
	rm -rf site

## Alias for clean
tidy: clean

## Generate PDF (not working yet because of some dependency issues)
pdf:
	ENABLE_PDF_EXPORT=1 mkdocs build
