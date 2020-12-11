#!/bin/bash -ex

book_dir=learningtods

#copy configuration files
for file in _toc.yml _config.yml about.md requirements.txt
do
    rm ${book_dir}/$file
    cp $file ${book_dir}/$file
done

#copy notebook files
source_dir=notebooks
notebook_names=(Probability_Basics Probability_Basics_II Probability_Basics_III Common_Probability_Distributions_Discrete Classification_Basics)
for file in ${notebook_names[@]}
do
    cp ${source_dir}/${file}.ipynb ${book_dir}
done

jupyter-book build ${book_dir}

pushd ${book_dir}/_build/html
for file in ${notebook_names[@]}
do
    #need to change master to main in binder url for binder to work
    sed -i 's/\/master?/\/main?/' $file.html
    #insert MathJax script that renders latex correctly in html
    sed -i '/<head>/a <script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>' $file.html
done
popd

#publish code to github pages
#ghp-import -n -p -f ${book_dir}/_build/html
