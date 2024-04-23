
ENTRYPOINT=main
COMPILER=pdflatex

default: cycle

open: cycle
	open $(ENTRYPOINT).pdf

main:
	$(COMPILER) --shell-escape --synctex=1 $(ENTRYPOINT)

bib:
	bibtex $(ENTRYPOINT)

cycle:
	$(COMPILER) --shell-escape --synctex=1 $(ENTRYPOINT)
	bibtex $(ENTRYPOINT)
	$(COMPILER) --shell-escape --synctex=1 $(ENTRYPOINT)
	$(COMPILER) --shell-escape --synctex=1 $(ENTRYPOINT)

clean:
	rm -rf *.aux *.lof *.log *.lot *.synctex.gz *.toc svg-inkscape
	find . -type f -name '*.pdf' ! -name 'logo_name.pdf' ! -name 'logo_name_sv.pdf' -exec rm -f {} \;

diff.tex:
	@echo "This command assumes you have checked out the previous version"
	@echo "of the thesis you sent to your advisor/reviewer in prev.tex"
	@echo "(Use git to obtain the previous version ofc.)"
	@echo "The latexdiff tools is fragile, so you may have errors compiling"
	@echo "the diff.pdf afterwards unless you go in and edit it yourself."
	latexdiff prev.tex $(ENTRYPOINT).tex > diff.tex

diff: diff.tex
	$(COMPILER) --shell-escape --synctex=1 diff.tex
