DOT_DIR=$PWD
cd $HOME
for i in $DOT_DIR/.[a-zA-Z]*; do
    ln -s $i
done
