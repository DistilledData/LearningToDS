#!/bin/bash -ex

book_dir=learningtods

#copy configuration files
for file in _toc.yml _config.yml about.md requirements.txt
do
    rm ${book_dir}/$file
    cp $file ${book_dir}/$file
done

#copy images
image_dir=${book_dir}/images
source_dir=images
rm ${image_dir} || true
cp -r ${source_dir} ${image_dir}

#copy notebook files
notebook_dir=${book_dir}/notebooks
mkdir ${notebook_dir} || true
source_dir=notebooks
for file in Probability_Basics.ipynb Probability_Basics_II.ipynb Probability_Basics_III.ipynb Common_Probability_Distributions_Discrete.ipynb Classification_Basics.ipynb
do
    rm ${notebook_dir}/$file || true
    cp ${source_dir}/$file ${notebook_dir}
done

jupyter-book build ${book_dir}

pushd ${book_dir}/_build/html/notebooks
for file in $(ls)
do
    #need to change master to main in binder url for binder to work
    sed -i 's/\/master?/\/main?/' $file
    #insert MathJax script that renders latex correctly in html
    sed -i '/<head>/a <script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>' Probability_Basics.html
done
popd

#publish code to github pages
ghp-import -n -p -f ${book_dir}/_build/html
