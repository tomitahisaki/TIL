# 不正解解説
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

## hashの生成
`Hash[]`, `Hash{}`, `Hash.new` でhashを生成する

ハッシュリテラル、新ハッシュリテラル、クラスメソッドから作り出す方法
```
{:a => 1 :b => 2, :c => 3} 

[a: 1, b: 2, c: 3]

Hash[:a, 1 :b, 2, :c, 3]
```
```
Hash[a: 1, b: 2] => {:a => 1, :b => 2}
Hash[1,1] => {:1 ==> 1}
Hash[1,1,1] => odd number of arguments for Hash (ArgumentError)
{a:1, b:2} => {a:1, b:2}
{:a => 1}
{"a": 1}
{:"a" => 1}
```

## hash
`Hash.new`で生成されたときに、default引数が指定された際は、valueにdefaultがいる

> defaultで作成された要素は、pメソッドでは呼び出さない


## hashのメソッド
`[]=`	キーに対応する値を置き換えます。

`delete(:key)`	レシーバからキーの項目を削除します。破壊的メソッド

`reject!`	キーと値を引数としてブロックで評価した結果が真である要素を削除します。

`delete_if`	reject!の別名です。

`replace`	ハッシュの内容を引数の内容で置き換えます。

`shift`	ハッシュからキーが追加された順番で要素を取り除きます。取り除いた要素は [key, value]形式の配列で返します。

`merge!`	selfと引数のハッシュの内容をマージします。

`update`	merge!の別名です。 

`clear`	ハッシュの中身を空にします。

`fetch` hashのkeyに関連付けられた valueを返す

`member?` `has_key?` `include?` `key` `member?` は全て同じ意味を持つ 引数に与えたキーが存在するか判断している

default_proc
[公式ガイド: default_proc](https://docs.ruby-l  g.org/ja/latest/method/Hash/i/default_proc.html)

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

```
name = "alice"

puts "I am #{name}" => I am alice
puts 'I am #{name}' => I am #{name}
```

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

```
"find!find!find!find!find!find".index("!", 5)
=> 9 # 最初に見つかった文字を左端からカウントして返す
```

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
### 演算子の優先順位
```
高い   ::
       []
       +(単項)  !  ~
       **
       -(単項)
       *  /  %
       +  -
       << >>
       &
       |  ^
       > >=  < <=
       <=> ==  === !=  =~  !~
       &&
       ||
       ..  ...
       ?:(条件演算子)
       =(+=, -= ... )
       not
低い   and or
```

## 演算子のオーバーライド
ほとんどがされない

`..` `$$`がされる

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
`delete`は引数で渡された値と等しい要素を`self`から全て取り除く

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

`readline` １行読み込んで、成功時にその文字列を返す

`readlines` ファイルすべてを読み込む ``その各行を要素としてもつ配列を返す``

`write` 第1引数で指定したファイルを開き、第2引数に指定した文字列の書き込みを行ったファイルを閉じる。第3引数で書き込み位置を指定できる

`seek'(offset, whence)` ポインタを`whence`から`offset`に移動する

`IO::SEEK_CUR` 現在のポインタ位置

`IO.read`は第1引数で読み込みファイル、第2引数で読み込む文字、第3引数で読み込む位置を指定

list.txt
```
REx
Silver
REx
Gold
```
```
IO.read("list.txt", 3, offset= 1)
=> Ex\n
``` 

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

`chdir` カレントディレクトリのpathを変更する

`delete` `rmdir` からのディレクトリを削除するメソッド

`seek` ディレクトリの読み込み位置を引数(n)に移動させる

## 定数
メソッド内で、定数を定義出来ない

メソッドで複数回呼び出すことで、定数が不定となるため

SyntaxErrorが発生する

## ローカル変数

外部で定義したローカル変数はメソッド内で呼び出せない

変数名は、小文字やアンスコから始まる。 アルファベット、数字、アンスコ、非ASCII文字のみ。予約語は除く(予約語を含むなら良い)

## splat演算子(スプレッド演算子)
`(*)`でハッシュを展開できる

ハッシュは、ネストした配列で表現可能

下記のように展開可能なので、書きやすくなる

```
ary = [4,5,6]
[1,2,3] + ary + [7,8,9] => [1,2,3,4,5,6,7,8,9]

[1,2,3,*ary,7,8,9] => [1,2,3,4,5,6,7,8,9]
```

```
p [*1..10] => [1,2,3,4,5,6,7,8,910]

p [1..10] => [1..10]
```

## Time
時刻を表すクラス

`Time.now`で現在の時刻を表す

> 時刻を秒数で保持していることに注意

```
Time.now + 3600 # 秒数を足している
```



## 識別子
`<<識別子`行から `識別子`行 まで文字列として扱える ヒアドキュメント

インデントを加える時は、`<<-識別子` になるので注意！！

"識別子", 識別子 式展開できる

'識別子' 式展開できない

``識別子` はコマンド出力  
## メソッドと変数の優先順位
変数のほうが先に探索される

```
hoge = 0
def hoge
  x = 0
  5.times do |i|
    x += 1
  end
  x
end
puts hoge # 変数のほうが先に探索されるので、0が正しい
```

## collect map
各要素をブロックに評価した結果を配列にして返す

## find_all select
各要素をブロックに評価した結果が、真である要素の配列を作成して返す

`find`は、各要素をブロックに評価した結果が、真である最初の要素のみ

## hash
`key`は引数を1つ受け取る 返す値は、引数にあった値をもつキー

`values_at`は可変長引数をとる(複数引数) 引数に指定したキーの値を集めた配列を返す

`values`はhashの全値(value)の配列を返す

`store` keyにvalueを結びつけるメソッド 

`hash = hash[key, value]`のように定義できる

`hash.each` のようにブロックパラメータを渡す場合、ブロックパラメータのクラスは`Array`となる

`**`はhashをキーワード引数に変換する

```
japan = Class.new
# hash = {} のように先にハッシュ定義しても良い
hash.store(japan, "yen")

puts hash[japan] => yen
```

## クラス変数
@@変数名で表される

クラス変数に対して、アクセサメソッドは使えないので注意

`attr_accessor`などのようなメソッド

## sub
第1引数の検索対象と第2引数の置換後の文字列を使って1回だけ、レシーバの文字列を変換する

最初に検知される文字に対して、適応される。全部ではないので、注意！！

timesメソッドなどで回せば、回数分だけ変換される

## 条件範囲
`d == 3..d == 5`のような範囲指定ができる

```
10.times{|d| print d == 3..d == 5 ? "Yes" : "No" }
```

## %記法
%を使って、シンボルや配列などを表すことが可能 [参考サイト](https://www.sejuku.net/blog/46939)

`%W #w` 配列を表す 式展開があるのは`%W`

`%` だけだと文字列

`%s` シンボルにする

`%i` シンボルの配列 `%I` シンボルの配列で式展開 改行文字も含められる

## chop
末尾の文字を取り除く `\r\n`があればどちらとも取り除く

破壊的メソッドではない

## strip
文字列の先頭と末尾の空白文字`\t\r\n\f\v`を取り除く

`strip!`とすると、破壊的となる

## chomp
ただし引数がデフォルトのときは、`\n` `\r\n` `\n`の全てを改行コードとみなす

`\n`改行コードを取り除く

破壊的メソッドではない

> 下記のような違いに気をつける！！
```
"foo\r\n".chomp => "foo"

"foo\n\r".chomp => "foo\n"
```

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

## Fileクラスのメソッド
`file.dirname` は引数指定した文字列の一番後ろの/より前を返す

/がない場合は、.の前を返す

`open`
```
File.open('ファイル名', モード名) do |n|
  #処理 write,seekなど
end
```
モード名を変えることで、読み込みや書き込みの指示を与えている。文字列で引数を与える (参考)[https://uxmilk.jp/22615]

(openモード)[https://docs.ruby-lang.org/ja/latest/method/Kernel/m/open.html]

`r`(デフォルト)は読み書き `w`はファイル作成(0バイトにする)して、書き込み `a`は末尾に追記する(ファイルなければ作成する)

`+`がつくと、読み書きまでできるようになる

r	読み込みモード 先頭から読み込みのみ 一般的なケース  r+	読み込み + 書き込みモード 読み書き位置は先頭にセットされる

w	新規作成・書き込みモード(ファイルあれば、中身を空にする)   w+	新規作成・読み込み + 書き込みモード r+と同様 中身を空にする

a	追記書き込みモード 末尾に追記 ファイルなければ作成  a+	読み込み + 追記書き込みモード 末尾に追記 ファイルなければ作成

`chmod`ファイルのpermissionを変更するメソッド 引数に指定したファイルモードを変更します。
```
File.chmod(0644, "text.txt")
=> 所有者は読み書き可、実行不能
=> 所有グループとその他は読み込み可、書き込みと実行は不可
```

`delete` 引数に指定したファイルを削除する
```
File.delete("text.txt") => 1
```

`join` ディレクトリ名を連結したいときなどにつかう
```
puts File.join("a", "b") => "a/b"
puts File.join("/","user","bin") => /user/bin
```

`extname` 拡張子の部分を返す  `txt`や`rb`のような拡張子 拡張子がない場合は、`""`を返す。

`mtime` 最終時刻を返す。timestampの最終を返している？

`basename` パスの末尾を取得する。

`rename` 引数2つで、名前を変更できる。ディレクトリの移動も可能

## グローバル関数
$が先頭につく変数

どこからでも参照や変更が可能

## to_s(n)メソッド

stringに変換するメソッド

引数にn値を入れることで、n進数に変換した値が出力される
```
7.to_s(3) => 21
```

## sortメソッド
配列の並び替えを行いたいときに使うメソッド

<=>演算子を使って、配列の並び替えを行う。

ただし、文字列と数値のような比較できない要素があるとエラーが発生する

```
p [1, "a", 2, "b", 3, "c"].sort => ArgumentError
```
注意したいこと <=>演算子の使い方が重要

`sort{|a, b| a <=> b}` => 昇順

`sort{|a, b| b <=> a}` => 降順

### hashをsortすると
hashをsortする時は、a[1] <=> b[1]で比較する演算子には、各ペアの`value`を値の昇順に並べるという意味になる。

```
a = {"Foo" => "hoge", "Bar" => "piyo", "Baz" => "fuga"}
p a.sort{|a, b| a[1] <=> b[1]} # valueを比較している
=> [["Baz", "fuga"], ["Foo", "hoge"], ["Bar", "piyo"]]

p a.sort{|a, b| a[0] <=> b[0]} # keyを比較している
=> [["Bar", "piyo"], ["Baz", "fuga"], ["Foo", "hoge"]]
```

## <=>演算子
順序比較のために使われる

 - 左オブジェクトが右オブジェクトより小さい場合は、-1を返します。

 - 左オブジェクトが右オブジェクトと等しい場合は、0を返します。

 - 左オブジェクトが右オブジェクトより大きい場合は、1を返します。

```
puts 2 <=> 1  # 出力: 1
puts 2 <=> 2  # 出力: 0
puts 1 <=> 2  # 出力: -1
```

## reverse(Arrayクラス)
配列の要素を逆に並び替えるメソッド

成功すると、`0`を返す。引数に削除対象のディレクトリパスを文字列で指定する

## step
`step(limit, step)` でstepずつ加算していき、limitまでをブロックにわたす

```
5.step(10,1) do |i|
  puts i
end
=> 5
=> 6
=> 7
=> 8
=> 9
```
=> 10

## 多重代入
変数に対して代入する値が少ないときには、nilが格納される

下記の形には注意！
```
(x, y), z = 1, 2, 3
x => 1
y => nil
z => 2

(x, y), z = [1, 2], 3
x => 1
y => 2
z => 3
```

## String
`split` 引数の正規表現にマッチしたもので文字列を分解します
```
p "spring,summer,autumn,winter".split(/,/)
=> ["spring","summer","autumn","winter"]

# ()で囲むと全てが分解される
p "spring,summer,autumn,winter".split(/,/)
=> ["Spring", ",", "Summer", ",", "Autumn", ",", "Winter"]
```

`delete_prefix` 引数の文字列を先頭から削除した文字列を返す

## 例外処理

StandartErrorを継承しないクラスのインスタンスを指定すると、TypeErrorが発生する

例外捕捉するための書き方
```
begin

rescue KeyError

rescue StopIteration

end
```
```
begin

rescue KeyError, StopIteration

end
```
```
begin

rescue *[KeyError, StopIteration]

end
```
引数を渡す場合、`=>`をつける
```
rescue => e

rescue ZeroDivisionError => ex
```

`begin``end`は省略可能。

## オブジェクト生成
下記のメソッドで生成する

ただし、`start``fork`では、`initialize`が呼ばれないので注意！
```
Klass.new
Klass.start
Klass.fork
```

## unless else
`unless`は条件が成立しないときに実行される

`else`は使えるが、`elseif`は使えない

```
unless n = 3
  "3ではない"
# elsifは使えないので、
else
  "他の数字"
end
```

## any?(Arrayクラス)
ブロックの戻り値が`true`になると、繰り返しを止める

```
[1,2,3].any? {|n| n == 3 } => true
[1,2,3].any? {|n| n == 4 } => false
```

## zip(Arrayクラス)
配列の要素を引数の配列の各要素と組み合わせて、配列の配列を生成して返す

```
a1 = [1,2]
a2 = [3,4]
p a3 = a1.zip(a2) => [[1,3],[2,4]]
```

## concat(Arrayクラス)
自身の末尾に破壊的に連結する
```
array = [1, 2]
a = [3, 4]

array.concat a
p array => [1, 2, 3, 4]
```

## slice
指定された要素を返す。最初にマッチした文字列のみを返す

```
"hobepiyohobehobe".slice(/o../)
=> "obe"
```

## chrメソッド ordメソッド
`chr` はASCIIコードの数値などを文字列に変換するメソッド
```
p 49.chr
=> "1"

p 0x45.chr
=> "E"
```

`ord` は文字を数値に変換するメソッド
```
p "a".ord 
=> 97

p "A".ord
=> 65
```

## 正規表現
`0\d{1,4}-\d{1,4}-\d{4}` ０からはじまり、１つから４つの数字に一致。ハイフンのあとに、１つから４つの数字に一致。最後に４つの数字に一致

`/[A-Z][0-9]/` 任意の文字に一致する(AからZと0から9)

`/^[A-Z][^A-Z]+/`

## grep(pattern)
patternにあった要素を全て含んだ配列を返す

## Timeオブジェクト
`Time`は時刻を起算時からの経過秒数で保持している。

起算時は、協定世界時の1970年1月1日午前0時のことを指す