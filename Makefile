SHELL := /bin/bash

SOURCES = $(wildcard *.md)
HTMLs = $(patsubst %.md,docs/%.html,$(SOURCES))

all: mkdir copy_cname copy_resources copy_sitemap $(HTMLs)

mkdir:
	mkdir -p docs

copy_resources:
	cp -r resources docs

copy_cname:
	cp CNAME docs

copy_sitemap:
	cp sitemap.xml robots.txt docs

docs/%.html: %.md
	pandoc -s \
	  -c resources/tufte.css \
	  -c resources/mc.css \
	  --template=template.html \
	  -V "next-title=`grep $* next-titles.txt | cut -d : -f 2`" \
	  -V "next-subtitle=`grep $* next-subtitles.txt | cut -d : -f 2`" \
	  -V "next-url=`grep $*: next-urls.txt | cut -d : -f 2`" \
	  -f markdown \
	  -t html5 \
	  -o $@ $<

clean: 
	rm -rf docs
