## Ruby オプション
`-I`はファイルロードのパス指定できる

指定したディレクトリを$LOAD_PATH変数に追加する

ディレクトリは`require``load`で検索される

## throw catch
`throw`で呼んだときに、第1引数で指定したtagのあるcatchブロックの終わりまでジャンプする

第2引数に渡した値がメソッドの戻り値となる
```
a, b = catch :exit do
  for x in 1..10
    for y in 1..10
      throw :exit,[x, y] if x + y == 10
    end
  end
end
puts a, b
```
```
def find_something
  # stub
  throw :found, "found!"
end

puts "catch前"
msg = catch(:found) do
  puts "throw前"
  find_something
  puts "throw後" # 実行されないよ
end
puts msg
puts "catch後"

# catch前
# throw前
# found!
# catch後

```

## undef
指定された定義を取り消す  aliasと同様に引数にメソッドかシンボルで指定できる
```
module Mod
  def foo
    puts 'Mod'
  end
end

class Cls1
  def foo
    puts 'Cls1'
  end
end

class Cls2 < Cls1
  include Mod
  undef foo
end
Cls2.foo
```

## 配列の多重代入
```
a,b = [1,2]
p a => 1
p b => 2
```

## sort
ブロック引数内で比較のアルゴリズムを記述

2種類の方法で書ける
```rb
x = ["abc","defgk","lopq"]
p x.sort{|a,b| a.size <=> b.size}
p x.sort{|a,b| a.size - b.size}
=> ["abc","lopq","defgk"]
```

## YAML
YAMLデータはハッシュで読み込まれる
```
require "yaml"

dir = <<EOL
file:1
  name: app.rb
  data: ruby
EOL

p YAML.load(dir)
=> {"file1"=>{"name"=>"app.rb","data"=>"ruby}}
```

## 定数の探索
自分のクラス→外側のクラスの順で行われる

```
class C1
  MS = "ms1"
  MS2 = "ms2"
  class C2
    MS2 = "C2:ms2"
    puts MS
    puts MS2
  end
  puts MS
  puts MS2
end
=> ms1
=> C2:ms2
=> ms1
=> ms2
```

## exit
組み込み関数`exit`は、例外処理`SystemExit`が発生する

`rescue`すると、実行を継続。しないと終了

## stringioライブラリ
`IO`オブジェクトと同じインターフェースをもたせる`StringIO`クラスを含む

StringIOクラスは、IOクラスを継承していない

## Objectクラス
トップレベルで定義する場合の可視性は、`private`になる

下記の2つは同じ意味のコード
```
def foo
  puts "hello"
end
```
```
class Object
  private
  def foo
    puts "hello"
  end
end
```

## rdoc
Rubyのドキュメント生成を行うためのライブラリ  

コメント部分で使えるマークアップの記法も存在している