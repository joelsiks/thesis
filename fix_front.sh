#/bin/bash

# Fix frontpage

# Create blank page
gs -o blank.pdf -sDEVICE=pdfwrite -g5950x8420 -c "showpage"

pdftk frontpage.pdf cat 1 output part1.pdf
pdftk frontpage.pdf cat 2-end output part2.pdf
pdftk part1.pdf blank.pdf part2.pdf cat output frontpage-fixed.pdf
rm part1.pdf part2.pdf blank.pdf

# Fix main.pdf

# Remove the first two pages
pdftk main.pdf cat 3-end output main-wo.pdf

# Combine frontpage with report.
pdftk frontpage-fixed.pdf main-wo.pdf cat output main-final.pdf

rm main-wo.pdf
