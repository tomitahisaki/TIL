# 不正解解説
default_proc
[公式ガイド: default_proc](https://docs.ruby-lang.org/ja/latest/method/Hash/i/default_proc.html)

hashのデフォルト値を返すProcオブジェクトを返す

ハッシュがブロック形式を持たない場合はnilを返す

default値をnilにしてしまえば、エラーは発生しない
```
hash = Hash.new {|h, k| raise(KeyError, "Key #{k} does not exist in hash #{h}") }

hash.default = nil
default_proc = nil

```
エラーが発生するのは
```
# 参照先がない
p hash[:a]

# defalut_procが格納されるproc変数に値を指定させても
# Key 2 does not exist in hash 1のようなエラーとなる
proc = hash.default_proc
p proc.call(1, 2)
```

## String#%
`String#%`はフォーマットされた文字列を返す

`%d`は、数値に対して意味を成す

```
p "hello%d" % 1
=> hello1
```

## コードの書き方
irbなどではだめですが、
ファイルで記述する場合は、SyntaxErrorにならない

また、`\`をいれることで一行のコードとみなされる。
```
(1..5).each
.reverse_each
.each do |n|
  puts n
end
```
```
(1..5).each\
.reverse_each\
.each do |n|
  puts n
end
```
## 8, 10, 16進数
```
hex # 16進数表記, 0xから始まる, 0~F
oct # 8進数表記, 0から始まる, 0~7
to_i # 10進数表記, 0~9
```

## partition
指定されたものとそれ以外を分割するメソッド

## invert
keyとvalueを入れ替えるメソッド

ただし、入れ替え後のkeyが重複した場合は、後に定義されたものが優先

## to_i(n)
`to_i`だと10進数表記

`to_i(n)`だとn進数表記

## Fileクラスのメソッド
`file.dirname` は引数指定した文字列の一番後ろの/より前を返す

/がない場合は、.の前を返す

## hashのメソッド
`[]=`	キーに対応する値を置き換えます。

`delete`	キーを削除します。

`reject!`	キーと値を引数としてブロックで評価した結果が真である要素を削除します。

`delete_if`	reject!の別名です。

`replace`	ハッシュの内容を引数の内容で置き換えます。

`shift`	ハッシュからキーが追加された順番で要素を取り除きます。取り除いた要素は [key, value]形式の配列で返します。

`merge!`	selfと引数のハッシュの内容をマージします。

`update`	merge!の別名です。

`clear`	ハッシュの中身を空にします。

## injectメソッド
ブロックを使用し、繰り返し計算をする

引数指定しないと、要素1が初期値となる
```
p [1,2,3].inject{|x,y| x + y * 2}
=> 1 + 2 * 2 = 5
=> 5 + 3 * 2 = 11
```
引数指定すると戻り値が初期値となる

今回は、0が初期値
```
p [1,2,3].inject(0){|x,y| x + y * 2}
=> 0 + 1 * 2 = 2
=> 2 + 2 * 2 = 6
=> 6 + 3 * 2 = 12
$ 12
```
空のArrayを初期値としている
```
p [1,2,3].inject([]){|x, y| x << y ** 2}
=> [] << 1 ** 2 = [1]
=> [1] << 2 ** 2 = [1,4]
=> [1,4] << 3 ** 2 = [1,4,9]
```

## 式展開
`" "` で囲むと式展開可能

`' '` で囲むと式展開できない

## equal? eql?
`equal?` は同一オブジェクトのときに真偽値を返す

`eql?` は同一文字列のときに真偽値を返す
```
a = "sushi"
b = 'sushi'

a.equal? b => false # 同一オブジェクトではない
a.eql? b => true # 同一文字列なのでtrue
```

## delete
引数に指定した文字を削除する
`^`がつくと、指定した文字以外を削除する

## Proc
Procオブジェクト current変数は共有されない
```
def hoge(step = 1)
  current = 0
  Proc.new {
    current += step
  }
end

p1 = hoge
p2 = hoge(2)

p1.call
p1.call
p1.call
p2.call
p2.call

p p2.call
=> 6
```
