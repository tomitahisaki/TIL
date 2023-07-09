## chop
末尾の文字を取り除く `\r\n`があればどちらとも取り除く

## strip
文字列の先頭と末尾の`\t\r\n\f\v`を取り除く

`strip!`のすると、破壊的となる

## chomp
`\n`改行コードを取り除く

## hashのエラー
```
hash = Hash.new {|h, k| raise(KeyError, "Key #{k} does not exist in hash #{h}") }

p hash[:a] # キーがないので例外発生

hash.default = nil
p hash[:a] # defaultをnilにしているので、例外にならない

proc = hash.default_proc
p proc.call(1,2) # 2のキーは無いので、例外発生

hash.default_proc = nil
p hash[:a] # defaultをnilにしているので、例外にならない
```

## member?
キーを持つか判断できる

```
hash.member?(key) => true || false
```

## File openメソッド
```
File.open('ファイル名', モード名) do |n|
  #処理 write,seekなど
end
```
モード名を変えることで、読み込みや書き込みを返る
`w w+`は読み込み、書き込みをする  上書きをする
`a a+` は読み込み、追記書き込みをする 読み込みは先頭からして、書き込みはファイルの末尾にする

## hash
`Hash.new`で生成されたときに、default引数が指定された際は、valueにdefaultがいる

> defaultで作成されたようそは、pメソッドでは呼び出さない

## fetch
hashのkeyに関連付けられた valueを返す

## グローバル関数
$が先頭につく変数

どこからでも参照や変更が可能


