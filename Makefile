RESOURCEDIR = "resources"
TARGETDIR = "docs"


SOURCES = $(wildcard *.md)
HTMLs = $(patsubst %.md,$(TARGETDIR)/%.html,$(SOURCES))

all: mkdir copy_resources $(HTMLs)

mkdir:
	mkdir -p $(TARGETDIR)

copy_resources:
	cp -r $(RESOURCEDIR) $(TARGETDIR)

$(TARGETDIR)/%.html: %.md
	pandoc -s -c $(RESOURCEDIR)/tufte.css -c $(RESOURCEDIR)/mc.css --template=template.html -f markdown -t html5 -o $@ $<

clean: 
	rm -rf $(TARGETDIR)
