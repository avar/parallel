#!/bin/bash

echo "### Test --basenamereplace"
parallel -j1 -k -X --basenamereplace FOO echo FOO ::: /a/b.c a/b.c b.c /a/b a/b b
parallel -k --basenamereplace FOO echo FOO ::: /a/b.c a/b.c b.c /a/b a/b b

echo "### Test --bnr"
parallel -j1 -k -X --bnr FOO echo FOO ::: /a/b.c a/b.c b.c /a/b a/b b
parallel -k --bnr FOO echo FOO ::: /a/b.c a/b.c b.c /a/b a/b b

echo "### Test --basenameextensionreplace"
parallel -j1 -k -X --basenameextensionreplace FOO echo FOO ::: /a/b.c a/b.c b.c /a/b a/b b
parallel -k --basenameextensionreplace FOO echo FOO ::: /a/b.c a/b.c b.c /a/b a/b b

echo "### Test --bner"
parallel -j1 -k -X --bner FOO echo FOO ::: /a/b.c a/b.c b.c /a/b a/b b
parallel -k --bner FOO echo FOO ::: /a/b.c a/b.c b.c /a/b a/b b

echo "### Test {/}"
parallel -j1 -k -X echo {/} ::: /a/b.c a/b.c b.c /a/b a/b b

echo "### Test {/.}"
parallel -j1 -k -X echo {/.} ::: /a/b.c a/b.c b.c /a/b a/b b

echo "### Test {#/.}"
parallel -j1 -k -X echo {2/.} ::: /a/number1.c a/number2.c number3.c /a/number4 a/number5 number6

echo "### Test {#/}"
parallel -j1 -k -X echo {2/} ::: /a/number1.c a/number2.c number3.c /a/number4 a/number5 number6

echo "### Test {#.}"
parallel -j1 -k -X echo {2.} ::: /a/number1.c a/number2.c number3.c /a/number4 a/number5 number6

SERVER1=parallel-server3
SERVER2=parallel-server2
rm -rf tmp

echo "### Test combined -X --return {/}_{/.}_{#/.}_{#/}_{#.} with files containing space"
stdout parallel -j1 -k -Xv --cleanup --return tmp/{/}_{/.}_{2/.}_{2/}_{2.}/file -S parallel@$SERVER2 \
mkdir -p tmp/{/}_{/.}_{2/.}_{2/}_{2.} \;touch tmp/{/}_{/.}_{2/.}_{2/}_{2.}/file \
::: /a/number1.c a/number2.c number3.c /a/number4 a/number5 number6 'number 7' 'number <8|8>'
find tmp
rm -rf tmp

echo "### Here we ought to test -m --return {/}_{/.}_{#/.}_{#/}_{#.} with files containing space"
echo "### But we will wait for a real world scenario"
