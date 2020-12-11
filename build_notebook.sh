#!/bin/bash -ex

book_dir=learningtods

for file in _toc.yml _config.yml about.md requirements.txt
do
    rm ${book_dir}/$file
    cp $file ${book_dir}/$file
done

jupyter-book build ${book_dir}

ghp-import -n -p -f ${book_dir}/_build/html
