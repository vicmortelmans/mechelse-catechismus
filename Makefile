SOURCES = $(wildcard *.md)
HTMLs = $(patsubst %.md,docs/%.html,$(SOURCES))

all: mkdir copy_cname copy_resources $(HTMLs)

mkdir:
	mkdir -p docs

copy_resources:
	cp -r resources docs

copy_cname:
	cp CNAME docs

docs/%.html: %.md
	pandoc -s -c resources/tufte.css -c resources/mc.css --template=template.html -f markdown -t html5 -o $@ $<

clean: 
	rm -rf docs
