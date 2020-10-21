RESOURCEDIR = "resources"
TARGETDIR = "build"


SOURCES = $(wildcard *.md)
HTMLs = $(patsubst %.md,build/%.html,$(SOURCES))

all: mkdir copy_resources $(HTMLs)

mkdir:
	mkdir -p $(TARGETDIR)

copy_resources:
	cp -r $(RESOURCEDIR) $(TARGETDIR)

build/%.html: %.md
	pandoc -s -c $(RESOURCEDIR)/tufte.css -c $(RESOURCEDIR)/mc.css --template=template.html -f markdown -t html5 -o $@ $<

clean: 
	rm -rf $(TARGETDIR)
