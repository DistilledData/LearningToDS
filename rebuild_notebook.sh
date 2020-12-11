#!/bin/bash -ex

for file in Probability_Basics.ipynb Probability_Basics_II.ipynb
do
    rm learningtods/notebooks/$file || true
    cp notebooks/$file learningtods/notebooks
done
#cp -r images my-book
cp about.md learningtods/
cp _toc.yml learningtods/
cp requirements.txt learningtods/
cp _config.yml learningtods/

jupyter-book build learningtods

git rm -r docs
git rm -r jupyter_execute
git commit -m "remove stale webpages"

cp -r learningtods/_build/html docs
cp -r learningtods/_build/jupyter_execute .
git add html
git add jupyter_execute
git commit -m "add current webpage"
