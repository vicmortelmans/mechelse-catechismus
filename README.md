# Mechelse Catechismus
Beknopte Verklaring van de Mechelse Catechismus ten gebruike van het Middelbaar Onderwijs

My toolstack:

- vim with mkdx plugin for markdown editing
- pandoc for converting markdown to html5
- wkhtmltopdf (with Qt patches: https://wkhtmltopdf.org/downloads.html) for generating pdf output, after assembling the content using awk
- Makefile for building the lot (inspired by https://github.com/eakbas/TSPW)
- tufte classless css theme (https://github.com/edwardtufte/tufte-css) 
- tufte fonts (https://github.com/edwardtufte/et-book/tree/gh-pages/et-book)
- mcmilk sitemap.xml generator bash script, slightly adapted (https://github.com/mcmilk/sitemap-generator)
