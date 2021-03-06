SHELL := /bin/bash

SOURCES = $(wildcard *.md)
HTMLs = $(patsubst %.md,docs/%.html,$(SOURCES))

all: mkdir copy_cname copy_resources $(HTMLs) sitemap 

mkdir:
	mkdir -p docs

copy_resources:
	cp -r resources docs

copy_cname:
	cp CNAME docs

sitemap:
	./sitemap.sh
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

book:
	awk -f merge.awk backcover.md les*.md verantwoording.md | pandoc -s \
	  -c resources/tufte.css \
	  -c resources/mc.css \
	  -c resources/mc-print.css \
	  -f markdown \
	  -t html5 > body.html
	wkhtmltopdf \
	  -T 20 -R 10 -B 35 -L 10 \
	  page body.html --footer-center [page] --footer-font-name ETBembo --footer-spacing 10 \
	  --enable-local-file-access \
	  toc --xsl-style-sheet toc.xsl \
	  body.pdf
	pdftk \
	  mc-cover.pdf blank.pdf body.pdf blank.pdf blank.pdf \
	  cat output mechelse-catechismus-1623.pdf
	cp mechelse-catechismus-1623.pdf docs

clean: 
	rm -rf docs
