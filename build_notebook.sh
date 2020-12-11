#!/bin/bash -ex

book_dir=learningtods

for file in _toc.yml _config.yml about.md requirements.txt
do
    rm ${book_dir}/$file
    cp $file ${book_dir}/$file
done

jupyter-book build ${book_dir}

#need to change master to main in binder url for binder to work
pushd ${book_dir}/_build/html/notebooks
for file in $(ls)
do
    sed -i 's/\/master?/\/main?/' $file
done
popd

ghp-import -n -p -f ${book_dir}/_build/html
