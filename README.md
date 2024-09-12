# Tablacus DOS cmd 2

Tablacus DOS cmdはMSXのBASICからDOSコマンドを実行させるソフトです。  
DOS2カーネルを持ちプライマリマッパーRAMが256KB以上のMSXで実行できます。

[Tablacus DOS cmd](https://github.com/tablacus/doscmd)はDOSに48KB、BASICに16KBを共存させて使う形になるにの対し、こちらはマッパーRAMを使って、BASIC、DOS共に64KBのRAMをフルに使える点になります。

## インストール

```bas
BLOAD"DOSCMD.BIN",R
```
Tablacus DOS cmd 2はBASIC領域を移動させないので`NEW`状態にはなりません。

## DOSコマンドの実行

引数「BAR」でFOO.COMを実行する場合は以下のようにします。実行ファイルの指定には必ず拡張子の「.com」も必要です。

```bas
CMD "FOO.COM BAR"
```

COMファイルの指定に階層ディレクトリを指定することができます。

```bas
CMD "A:\DIR\FOO.COM BAR"
```
## サンプル

WebMSXを使ったサンプルです。BPBINFO.COMを実行しています。

MSX turbo R  
https://webmsx.org/?MACHINE=MSXTR&DISKA=https://github.com/tablacus/doscmd2/raw/main/doscmd2.dsk

## ライセンス

[Apache-2.0 license](https://github.com/tablacus/doscmd2/blob/main/LICENSE)のオープンソースです。

※有料、無料にかかわらず同人ソフトに組み込んで配布してもらっても問題ありません。


