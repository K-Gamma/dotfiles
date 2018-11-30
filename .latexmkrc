#!/usr/bin/env perl

$latexargs        = '-kanji=utf8 -synctex=1 -file-line-error -src-specials -shell-escape -halt-on-error';
$latexsilentargs  = $latexargs . ' -interaction=batchmode';
$latex            = 'uplatex ' . $latexargs;
$latex_silent     = 'uplatex ' . $latexsilentargs;
#$latex            = 'platex ' . $latexargs;
#$latex_silent     = 'platex ' . $latexsilentargs;
$dvipdf           = 'dvipdfmx -f takao.map %O -o %D %S';
#$bibtex           = 'pbibtex';
$bibtex           = 'upbibtex';
$biber            = 'biber --bblencoding=utf8 -u -U --output_safechars';
$pdf_mode         = 3; # Use dvipdfmx
$pdf_previewer    = 'evince %O %S'

## lualatex
#$pdflatex                    = 'lualatex -shell-escape';
#$pvc_view_file_via_temporary = 0;
#$pdf_mode                    = 1; # Use pdflatex
