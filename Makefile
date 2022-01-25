pdf:
	pandoc -V  documentclass=book -o git-introduction.pdf README.md --latex-engine=xelatex
