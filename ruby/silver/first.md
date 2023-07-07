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
## 2, 8, 10, 16進数
```
hex # 16進数表記, 0xから始まる, 0~F
oct # 8進数表記, 0o,0から始まる, 0~7
to_i # 10進数表記, 0dからはじまる, 0~9 
to_i(2) # 2進数表記 0bから始まる, 0~1
```

## partition
指定されたものとそれ以外を分割するメソッド

## invert
keyとvalueを入れ替えるメソッド

ただし、入れ替え後のkeyが重複した場合は、後に定義されたものが優先

## to_i(n)
`to_i`だと10進数表記

`to_i(n)`だとn進数表記

ただし `n=0`の場合は、レシーバの接頭辞から判断する

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
[公式](https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/inject.html)

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
Procオブジェクト 

下記の場合にcurrent変数は共有されない
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

## to_a
stringに`to_a`メソッドはない

下記のように調べられる
```
オブジェクト.method_defined?(:メソッド)
```

## index
[公式](https://docs.ruby-lang.org/ja/latest/method/String/i/index.html)

`index(pattern, pos = 0)`

左から posに向かってpatternを検索する

最初に見つかった文字列の左端のインデックスを返す

pattern: 文字列もしくは正規表現

pos: 負の数だと文字列末尾から検索

## abs
絶対値を返す

## succ
次の整数を返す

nextと同じ

```
0.succ => 1
"aa".suc => "ab"
"1.9.9".succ => 2.0.0
```

## 論理演算子
`||` `&&`の演算子について

左辺で評価が決まる場合は、右辺を考慮しない

`||`なら、左辺がtrueなら処理が終わる

`&&`なら、左辺がfalseなら処理が終わる
```
1 || nil => 右辺は評価していない
nil && 1 => 右辺は評価しない
```

## 演算子
`|` は、集合の和演算

`&` は、積演算

```
a = [-1, 2, 3, 4, 5]
b = [4, 5, 6]

(a | b) => [-1, 2, 3, 4, 5, 6]
(a & b) => [4, 5]

(a || b) => a
(a && b) => b
```

## strftime
[strftimeメソッド](https://docs.ruby-lang.org/ja/latest/method/Time/i/strftime.html)

引数のフォーマット文字列を日付で返す

フォーマットの文字列によって、意味が異なるので注意

大文字小文字でも異なる

## flatten
平坦化するメソッド "！"感嘆符は破壊的かどうか

ｎ次元配列を1次元配列に返す

平坦化されない場合は、nilを返す

## delete delete_if reject
`delete`は引数で渡された値と等しい要素を`self`から取り除く

`delete_if`は1要素ずつブロックに渡して、結果が真の要素を取り除く

`delete_if`は`reject!`と同じ意味を持つ

```
a = [1, 2, 3, 4, 5]
a.delete_if{|n| n % 2 == 0} # a.reject{|n| n % 2 == 0}
puts a => [1, 3, 5]

a.delete(2)
puts a => [1, 3, 4, 5]
```

## scan
レシーバ(オブジェクト)に対して、引数で指定したパターンにマッチした部分文字列を配列で返す

 ```
str = "aaabbcccddd"
p str.scan("c")

=> ["c", "c", "c"]
 ```

 ## shift unshift push pop
`shift` 先頭から1要素を破壊的に取り出す

`unshift` 先頭に1要素を破壊的に追加する

`push` 末尾に1要素を破壊的に追加する

`pop` 末尾から1要素を破壊的に取り出す

## == eql? equal?
`==` Fixnumにあるメソッド 数値として等しいかどうか

`eql?` Numericクラスのメソッド 同じクラス && 数値 が等しいかどうか

`equal?` BasicObjectクラス オブジェクトIDが正しいかどうか

イミュータブルオブジェクトは常に同じIDとなる

## each_with_index
レシーバに指定されたオブジェクトの要素とインデックスを繰り返しブロックに渡す
```
[1,2,3].each_with_index do |value, index|
  puts "#{index} #{value"}
end

=>0 1
=>1 2
=>2 3
```

## IOクラス
IOクラスは、基本的な入出力機能のためのクラス [公式ガイド](https://docs.ruby-lang.org/ja/latest/class/IO.html)

`eof`はファイル終端になると、trueを返す

`readlines` ファイルすべてを読み込む ``その各行を要素としてもつ配列を返す``

`write` 第1引数で指定したファイルを開き、第2引数に指定した文字列の書き込みを行ったファイルを閉じる。第3引数で書き込み位置を指定できる

`seek'(offset, whence)` ポインタを`whence`から`offset`に移動する

`IO::SEEK_CUR` 現在のポインタ位置

```
io = File.open('list.txt') # ファイルを開いてio変数に代入する

while not io.eof? #  notで条件を反転 io.eof?がtrueじゃない限り 続ける
  io.readlines # 全部読み込み後に、ポインタは終端にある
  io.seek(0, IO::SEEK_CUR) # 現在の位置から0文字移動する
  p io.readlines # 最終行の要素を配列として返す
end
```

## 区切り文字
区切り文字は正規表現とは違うので注意
```
str = "1;2:3;4"
p str.split(";|:")
=> ["1;2:3;4"]

p str.split(/;|:/)
=> [1,2,3,4]
```

## compact
配列から、nilを取り除くメソッド
```
a = [1]
=> [1]
a[5] = 10
=> [1,nil,nil,nil,10]
a.compact!
=> [1,10]
```

## each_cons(cnt)
配列から、cnt個ずつ要素を取り出し、ブロックに渡す

要素が一つずつ進む。

```
(1..5).each_cons(3){ |arr| p arr}
=> [1, 2, 3]
=> [2, 3, 4]
=> [3, 4, 5]
```

`each_slice`が似たメソッドとしてある

引数ごとに、要素が出力される
```
(1..5).each_slice(3){ |arr| p arr}
=> [1, 2, 3]
=> [4, 5]
```
## Dirクラスのメソッド
ディレクトリの操作を行うメソッド

`Dir.pwd` カレントディレクトリのフルパスを示す


