#!/bin/sh

for i in .[a-zA-Z]* ; do
    if [ "$i" != ".git" ]; then
        (cd $HOME && [ -h "$i" ] && rm $i && ln -s .dot-files/$i && ls -l $i)
    fi
done
