all: content.png users.png

%.png: %.puml
	plantuml $<

.PHONY: watch
watch:
	python watch.py
