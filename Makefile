.PHONY: run build clean deploy pdf

run:
	mkdocs serve

build:
	mkdocs build

deploy: build
	rsync -e ssh -avz site/ doc.aipress24.com:doc.aipress24.com/

clean:
	rm -rf site

tidy: clean

pdf:
	ENABLE_PDF_EXPORT=1 mkdocs build
