#!/bin/bash

#出力ファイル:
#    Makefile.1 : 依存関係一覧
#    Makefile.2 : ソース一覧

export MK_DEPENDS=Makefile.1
export MK_SOURCES=Makefile.2
export SRCDIR=src
export SUFFIX="*.cpp"

#Makefileの初期化
echo -n > $MK_DEPENDS
echo -n "SRCS := " > $MK_SOURCES

#SRCDIR直下の全cppファイルに対して操作する
find $SRCDIR -name $SUFFIX | while read -r f; do
        #依存関係を出力
	clang -MM $f >> $MK_DEPENDS
        #ソース一覧に追加
	echo -n "$f " >> $MK_SOURCES
done

echo >> $MK_SOURCES
