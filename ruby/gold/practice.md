# 不正解ポイント
## protectメソッド
自クラスかサブクラスのレシーバーへ公開されているが、それ以外には隠蔽されている。

仲間クラス(自クラス、サブクラス)から参照するためにメソッドとしては公開されている。

## method_missing
継承チェーンを辿った末にメソッドが見つからない場合に呼び出される。

Bクラスのメソッドを呼び出すが、見つからずにClassクラスのインスタンスメソッドが呼ばれて、`method_missing`が呼ばれる。
```
class Class
  def method_missing(id, *args)
    puts "Class#method_missing"
  end
end
class A
  def method_missing(id, *args)
    puts "A#method_missing"
  end
end
class B < A
  def method_missing(id, *args)
    puts "B#method_missing"
  end
end

B.dummy_method => Class#method_missing
```

`class << self; end` こちらで定義されるメソッドは、特異クラスのインスタンスメソッドになる。
```
module M
  def method_missing(id, *args)
    puts "M#method_missing"
  end
end
class A
  include M
  def method_missing(id, *args)
    puts "A#method_missing"
  end
end
class B < A
  class << self
    def method_missing(id, *args)
      puts "B.method_missing"
    end
  end
end

B.new.dummy_method => A#method_missing
```

## 1i Complexクラス
複素数を扱うNumericクラスのサブクラス

Complex同士の計算は、Complexを返す。

## const_getメソッド
定義されている定数の値を取り出すメソッド

## YAML
設定ファイルとしてよく扱う。yamlファイル

hash array の組み合わせをインデントで表す。

yamlを読み込むには、`YAML.load(io)` `YAML.load(str)`がある。

```
require 'yaml'

yaml_data = <<-DATA
- Red
- Green
- Blue
---
- Yellow
- Pink
- White
DATA
YAML.load(yaml_data) => ["Red", "Green", "Blue"]
```

## 定数
"100"を出力するには、`Object::CONST` `CONST`

"010"は、`C::CONST`

"001"は、`C.singleton_class::CONST`

```
class Object
  CONST = "100"
end

class C
  CONST = "010"
  class << self
    CONST = "001"
  end
end
```

## singleton
特異クラス 指定したインスタンスだけに適用される特別なクラス。

### instance
クラスメソッドを呼び出せる。

## Proc
ブロックをオブジェクト化したProcクラスのインスタンス

メソッドと変数の検索順位では、変数が先となる。
```
def foo(n)
  n
end

foo = Proc.new{ |n| n * 2 }

puts foo[2]
```
{}内は、ブロックとして扱われるので `yield`に代入される
```
def bar(n)
  p n  => 1
  p yield => 2
  p n + yield => 3
end

bar(1){ 2 }
```

## Module
### extend
引数に指定したモジュールのメソッドを特異メソッドとして追加する

`methods.include? :メソッド名` で特異メソッドがあるかbooleanで返す

`methods`で特異メソッドの一覧を取得

### include
ModuleのインスタンスメソッドをMix-inするメソッド

`methods` では取得できない(インスタンスメソッドのため)

`instance_methods`で取得可能

## Refinement
メソッドの変更をグローバルにしないために、モジュール定義の中だけで呼び出す 

有効な部分を絞り込んでおく。(ファイルの終わりまでなど)

これがないと、メソッド名が重複などしたときに、他のメソッドやコードを破壊する可能性がある

### using
Refinementを有効にするために使用。
```
class C
  def m1
    100
  end
end

module M
  refine C do
    def m1
      200
    end
  end
end

puts C.new.m1 # 100 が表示されます

using M

puts C.new.m1 # 200 が表示されます
```

## Classクラス
`new`メソッドは、Classクラスのインスタンスメソッド。

StringやArrayなどは、Classクラスのインスタンスなので、引き継いでいる。

## objectクラス

### singleton_class
レシーバの特異クラスを返す。

```
Class.method_defined? :new => true # Classのインスタンスメソッド
String.method_defined? :new => false # Stringのインスタンスメソッドではない
Class.singleton_class.method_defined? :new => true # レシーバの特異クラス(クラスメソッド)を返す
String.singleton_class.method_defined? :new => true # 上記と同様
```

## レキシカルスコープ
変数の有効範囲：変数の有効範囲は、その変数が定義された場所によって決まる。つまり変数はその変数が含まれるブロックや関数、クラスなどのスコープ内で有効

ネストしたスコープ：ブロックや関数、クラスなどがネストした場合、内側のスコープから外側のスコープにアクセス可能。逆は不可。

同名の関数：同名の変数が複数のスコープで定義されている場合、レキシカルスコープでは一番内側のスコープで定義された変数が優先される。
```
x = 10

def print_x
  puts x
end

def do_something
  x = 20
  print_x
end

do_something => 10
```

## block_given?
ブロックが渡される場合は、trueとなる。

## yield
ブロックの内容を評価する

## { } do .. end
｛｝のほうが結合度が高いため、実行結果に差がでる。

m1(m2) do .. endのような形 m1にブロックが与えられる。
```
m1 m2 do
  "hello"
end
=> m2
=> m1 hello
```

m2にブロックが与えられている。
```
m1 m2 { "hello" }
=> m2 hello
=> m1
```

## 