# 不正解ポイント
## protectメソッド
自クラスかサブクラスのレシーバーへ公開されているが、それ以外には隠蔽されている。

仲間クラス(自クラス、サブクラス)から参照するためにメソッドとしては公開されている。

`methods.include?` 仲間クラスから参照可能。

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
selfに定義されている定数の値を取り出すメソッド 自クラスに定義がない場合は、探索する クラス名を文字列で返す

Human#nameクラスはclass#nameをオーバーライドしている。
```
class Human
  NAME = "Unknown"

  def self.name
    const_get(:NAME)
  end
end

class Fukuzawa < Human
  NAME = "Yukichi"
end

puts Fukuzawa.name => Yukichi
```

## YAML
設定ファイルとしてよく扱う。yamlファイル

hash array の組み合わせをインデントで表す。

yamlを読み込むには、`YAML.load(io)` `YAML.load(str)`がある。YAMLデータをRubyオブジェクトにする

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
定数の探索順位はクラス内 -> スーパークラス -> クラス探索の順番(指定されない限り)

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

## singleton 特異クラス
特異クラス 指定したインスタンスだけに適用される特別なクラス。[公式](https://docs.ruby-lang.org/ja/latest/class/Singleton.html)

定義方法
```
class << 対象オブジェクト
end
```
特異クラス内の`@@val += 1` は初回のみ呼び出される。
```
class S
  @@val = 0
  def initialize
    @@val += 1
  end
end

class C < S
  class << C
    @@val += 1
  end

  def initialize
    @@val += 1
    super
  end
end

C.new
C.new

p C.class_variable_get(@@val) => 3
```

### instance
これ1つしか特異(クラス)メソッドがない。 クラス唯一のインスタンスを返す。

### singleton_class
レシーバの特異クラスを返す。インスタンスメソッド

特異クラスに対応したオブジェクトは指定されたインスタンスの生成元をスーパークラスとして指す。

クラスメソッドは、特異クラスのインスタンスメソッドと考えられる。(特異メソッド？)

=> クラス名もインスタンスと考えると、クラスメソッドはそのクラスに定義された特異メソッドといえるから。
```
foo1 = Foo.new # Fooクラスのインスタンス
def foo1.method_A
  "foo1 only"
end
p foo1.method_A => "foo1 only"
foo2 = Foo.new
p foo2.method_B => NoMethodError
```

```
Class.method_defined? :new => true # Classのインスタンスメソッド
String.method_defined? :new => false # Stringのインスタンスメソッドではない
Class.singleton_class.method_defined? :new => true # レシーバの特異クラス(クラスメソッド)を返す
String.singleton_class.method_defined? :new => true # 上記と同様
```

```
m = C.method :singleton_class
p m.owner # Kernel
```
特異クラスの継承関係にKernelモジュールがあるので、特異クラスの特異クラスのような取得ができる

```
class C
end

p C.singleton_class # #<Class:C>
p C.singleton_class.singleton_class # #<Class:#Class:C>>
```

### 特異クラスで`self`をつかう
レシーバのオブジェクトを取得できる

`オブジェクト.singleton_class`で特異クラスを取得可能。

もしくは、特異クラスで`self`を参照するとレシーバのオブジェクトがとれる。

```
class C
  def self._singleton
    class << C
      self # 特異クラスのみ有効なローカル変数
    end
  end
end

p C._singleton #<Class:C>
```
もしくは
```
class C
end
p C.singleton_class
```


## Module
### extend
引数に指定したモジュールのメソッドを特異メソッドとして追加する

`methods.include? :メソッド名` で特異メソッドがあるかbooleanで返す

=> 特異メソッドだとfalseになる。

`methods`で特異メソッドの一覧を取得

下記の方法で特異メソッドを呼び出せる
```
include Parent
extend self
```
```
extend Parent
```

### include
ModuleのインスタンスメソッドをMix-inするメソッド

継承関係は、includeしたクラスの上に位置する 複数追加した場合は、左側が先に探索される

```
module M1
end

module M2
end

class C
  include M1, M2
end

p C.ancestors => [C, M1, M2, Object, Kernel, BasicObject]
```
メソッド探索順も同様に`self`のあとに追加される。
```
module M
  def foo
    super
    puts "M#foo"
  end
end

class C2
  def foo
    puts "C2#foo"
  end
end

class C < C2
  def foo
    super
    puts "C#foo"
  end
  include M
end

C.new.foo
=> C2#foo
=> M#foo
=> C#foo
```

`methods` では取得できない(インスタンスメソッドのため)

`instance_methods`で取得可能

`methods.include? :メソッド名`で `true`となる

### prepend
モジュールのメソッドを特異メソッドとして追加する

```
module M1
end

module M2
end

class C
  prepend M1, M2
end

p C.ancestors => [M1, M2, C, Object, Kernel, BasicObject]
```

### module_eval
[module_evalとは](https://docs.ruby-lang.org/ja/latest/method/Module/i/class_eval.html)

メソッドを動的に定義できて、ブロックを評価できる

下記の場合は、ネストされた状態になく、トップレベルになる。
```
module A
  B = 42

  def f
    21
  end
end

A.module_eval do
  def self.f
    p B
  end
end

B = 15

A.f => 15
```

ブロックを利用しないかどうかで、トップレベルで定義するか変化する
```
# BLOCK: CONST is defined? false
# BLOCK: CONST is defined? true
# HERE_DOC: CONST is defined? true
# HERE_DOC: CONST is defined? false

mod = Module.new

# ネストが変化しない
mod.module_eval do
  CONST_IN_BLOCK = 100
end

# ネストが変化する
mod.module_eval(<<-EVAL)
  CONST_IN_HERE_DOC = 100
EVAL

puts "BLOCK: CONST is defined? #{mod.const_defined?(:CONST_IN_BLOCK, false)}"
puts "BLOCK: CONST is defined? #{Object.const_defined?(:CONST_IN_BLOCK, false)}"

puts "HERE_DOC: CONST is defined? #{mod.const_defined?(:CONST_IN_HERE_DOC, false)}"
puts "HERE_DOC: CONST is defined? #{Object.const_defined?(:CONST_IN_HERE_DOC, false)}"
```

### nesting
ネストの状態を表す

```
module SuperMod
  module BaseMod
    p Module.nesting => [SuperMod::BaseMod, SuperMod]
  end
end
```

## Refinement
メソッドの変更をグローバルにしないために、モジュール定義の中だけで呼び出す 

有効な部分を絞り込んでおく。(ファイルの終わりまでなど)

これがないと、メソッド名が重複などしたときに、他のメソッドやコードを破壊する可能性がある

### using
Refinementを有効にするために使用。

使う場所によっては、スコープ外となり無効となる
```
class C
  def m1
    400
  end
end

module M
  refine C do
    def m1
      100
    end
  end
end

class C
  using M
end

puts C.new.m1 => 400
```

***メソッドの中で呼び出すことはできない!!***

=> 呼び出した場合は、`RunTimeError`が発生する
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

***usingを2つのモジュールに使っても、有効になるのは1つのメソッドのみ!***

最後に書いた`using`が優先される。

今回は、`R2`が呼び出されて、m1メソッドは200となる

ただし、`R1`全て無効ではない。m2メソッドは、`R1`を呼び出している
```
class C
  def m1(value)
    100 + value
  end

  def m2(value)
    value + ", world"
  end
end

module R1
  refine C do
    def m1
      super 50
    end

    def m2
      super "Hello"
    end
  end
end

module R2
  refine C do
    def m1
      super 100
    end
  end
end

using R1
using R2

puts C.new.m1 # 200
puts C.new.m2 # # "Hello, world" 
```

## Classクラス
`new`メソッドは、Classクラスのインスタンスメソッド。

StringやArrayなどは、Classクラスのインスタンスなので、引き継いでいる。

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

トップレベルで定数が定義されているので、Objectクラスに定数があることが確認できる
```
mod = Module.new

mod.module_eval do
  EVAL_CONST = 100
end

puts Object.const_defined? :EVAL_CONST # trueと表示される
puts mod.const_defined? :EVAL_CONST # trueと表示される
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

## require loadの違い
どちらも外部ライブラリを読み込める。

***モジュールは読み込まないので注意***
### `require`
  - 同じファイルを1度のみロードする
  - `.rb` `.so`を自動補完する
  - ライブラリのロード
  - バイナリエクステンションもロード可能

### `load`
  - 無条件にロードする
  - 自動補完なし
  - 設定ファイルの読み込み
  - バイナリエクステンション読み込めない

```
module Test
  $num += 1
end
```
```
$num = 0
1..10.times do |n|
  load './test.rb'
end

puts $num => 10  # 無条件にロードされるので、
# require にすると1度のみロードされるので、 "1"が出力される
```

## Object::DATA
スクリプトの `__END__` プログラムの終り以降をアクセスする File オブジェクト。

`__END__` を含まないプログラムにおいては DATA は定義されません。
### _END_
`__END__`以降はファイルとして扱います。

## Proc lambda
2つの違いについて

| 特徴          | Proc          | lambda            |
| ------------- | ------------- | ----------------- |
| 引数の数      | 曖昧          | 厳密              |
| 引数の渡し方  | Proc.new{}    | x, y              |

`return` `break` `next call`以降が実行されない `call`以降も実行される
### lambda 
`call`するときに、引数の省略できない。
```
sums = 0

p1 = lambda { |x, y| 
  x, y = x.to_i, y.to_i
  sums = [x, y].max 
}

p1.call("1", "2")
p1.call("7", "5")
p1.call("9")

p sums => エラーが発生する
```

### Proc
```
sums = 0

p1 = Proc { |x, y| 
  x, y = x.to_i, y.to_i
  sums = [x, y].max 
}

p1.call("1", "2")
p1.call("7", "5")
p1.call("9")

p sums => 9
```

### Proc
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

Procは、`call`、`[]`で呼び出せる
```
def foo(n)
  n ** n
end

foo = Proc.new { |n|
  n * 3
}

puts foo[2] * 2 => 12
```
下記の処理の流れ
```
次のプログラムを実行するとどうなりますか

val = 100

def method(val) # ①最初に処理される。 yield(115)となるProcに渡される。
  yield(15 + val)
end

_proc = Proc.new{|arg| val + arg } # ②argの引数には、yield(115)の仮引数が入る。

p method(val, &_proc) => 215
```

## super
スーパークラスの同名メソッドが呼ばれる

ただし、引数ありのメソッドでsuperを呼び出す場合は、`super()`のように明示的に呼び出す必要がある。`super`のように書くと`ArgumentError`となる。

下記の様に用いる。
```
class S
  def initialize
    puts "S#initialize"
  end
end

class C < S
  def initialize(*args)
    super()  # 引数がメソッドにあるので`super`にすると`ArgumentError`になる
    puts "C#initialize"
  end
end

C.new(1,2,3)
```

### 無名の可変長引数
`def initialize(*)`はその表し方

`super`などを呼び出す場合、引数に気をつける必要がある。`initialize(*)`にすることで、 サブクラスの引数を意識する必要がなくなる。

```
class S
  def initialize(*)
    puts "S#initialize"
  end
end

class C < S
  def initialize(*args)
    super
    puts "C#initialize"
  end
end

C.new(1,2,3,4,5) 
=> S#initialize
=> C#initialize
```

## 例外処理の確認
```
begin 
  例外が発生しそうな処理
rescue
  例外を受け取ったときの処理 エラーメッセージなど
else
  エラーが発生しないときの処理
ensure
  エラーの有無に関わらず、実行される処理
end
```

### raiseを省略
`raise`を省略すると `RuntimeError`を発生させる
### rescueを省略
`rescue`の省略で、`StandardError`を捕捉する

`RuntimeError`は`StandardError`のサブクラス

## ブロック引数
ブロック引数は、仮引数の中で最後にする必要がある。

エラーが発生する。SyntaxErrorになる
```
def hoge(&block, *args)
  block.call(*args)
end

hoge(1,2,3,4) do |*args|
  p args.length > 0 ? "hello" : args
end
```````

`&block`を仮引数の最後にすることで、処理される。
```
def hoge(*args, $block)
  block.call(*args)
end

hoge(1,2,3,4) do |*args|
  p args.length > 0 ? "hello" : args
end
```

### ブロック引数と配列
下記の様なメソッドだと、hogeメソッドで、blockが呼ばれて処理される。

ブロック処理に渡しているブロック引数が`*args`のため、`[[1,2,3,4]]`が渡され、最終的な出力も`[[1,2,3,4]]`になる
```
def hoge(*args, &block)
  block.call(args)
end

hoge(1,2,3,4) do |*args|
  p args.length < 0 ? "hello" : args => [[1,2,3,4]]
end
```
ブロック引数が`args`だったら、一度しか配列にならない =>`hoge(*args, &block)`のとき出力は[1,2,3,4]となる。
```
def hoge(*args, &block)
  block.call(args)
end

hoge(1,2,3,4) do |args|
  p args.length < 0 ? "hello" : args => [[1,2,3,4]]
end
```

## 正規表現
`[]`に囲まれた文字に当てはまるものという形

`[12|34]` `|`があるが、`[]`内なので、[1,2,3,4]のどれかにあてはまることを意味する

## Rubyで使用可能なオプション
-l: 各行の最後に String#chop!を実行します。

-p: -nと同じだが$_を出力

## Date Time DateTime
全て、日付と時間を扱うクラス

### Date
日付のみを扱うクラス。時刻情報は含まれない。タイムゾーンに依存に依存しない。

計算は、Rationalクラス

### Time
日付と時刻を扱うクラス。ローカルタイムゾーンを考慮している。

計算は、Floatクラス

### DateTime
日付と時刻を扱うクラス。`Time`クラストの違いは、タイムゾーンを考慮している。

異なるタイムゾーンの比較などができる。

計算は、Rationalクラス

下記に違いを示す。
```
# Dateクラス
date = Date.today
puts date  # 例: 2023-07-27

# Timeクラス
time = Time.now
puts time  # 例: 2023-07-27 10:30:45 +0900

# DateTimeクラス
datetime = DateTime.now
puts datetime  # 例: 2023-07-27T10:30:45+09:00

```

## alias式
### alias_method 
メソッド内でメソッドに別名を付ける場合は、Module#alias_methodを使う

`alias_method :new, :old` `alias_method "new", "old"` 

**文字列かシンボルを受け取る**
```
class Human
  attr_reader :name

  alias original_name name
  # alias_method :original_name, :name でもよい


  def name
    "Mr. " + original_name
    # "Mr. " + @name という形で、インスタンス変数を呼んでもOK
    # ただし、nameだけにするとメソッド参照するので例外が発生する
  end

  def initialize(name)
    @name = name
  end
end

human = Human.new("Andrew")
puts human.name
```

### alias
メソッドやグローバル変数に別名をつけられる

`alias new old`  `alias :new :old`  `alias $new_global $old_global`

## Enumerable
ArrayやHashクラスなどにインクルードされているモジュール。全てのメソッドがeachメソッドをもとに定義されているので、eachメソッドが定義されているクラスであれば、多くのメソッドを使える

Enumerableをincludeした場合は、eachメソッドの実装が必要。ブロックが渡されないときでも、Enumeratorオブジェクトを返すようにして外部イテレータとして使えるようにする。
```
class IPAddr
  include Enumerable

  def initialize(ip_addr)
    @ip_addr = ip_addr
  end

  def each
    return enum_for unless block_given?  # to_enumでもよい

    @ip_addr.split('.').each do |octet|
      yield octet
    end
  end
end

addr = IPAddr.new("192.10.20.30")
enum = addr.each
```

## JSON
JavaScript Object Notationを扱うためのモジュール

### load parse
`JSON.load` `JSON.parse`で引数にJSONの文字列を指定するとHashオブジェクトに変換する

## Fiber
軽量スレッドを提供する  他の言語では、coroutineやsemicoroutineとよばれる。

[公式 Fiberクラス](https://docs.ruby-lang.org/ja/latest/class/Fiber.html)

Fiber#resume により子へコンテキストを切り替える

=> Fiber.yieldが最後に実行した行からの再開、Fiber.newにしたブロックの最初の評価を行う。

Fiber.yield により親へコンテキストを切り替える

例1
```
f = Fiber.new do |name|
  Fiber.yield "Hi, #{name}"
end

p f.resume('Matz') # 'Hi, Matz'と表示されます。yieldで処理が切り替わる。Fiber.yieldに引数は、'Hi Matz'となる 終了せずに、実行中
p f.resume('Akira') # 'Akira'と表示されます。実行すると、Fiber.yield('Hi Matz')の戻り値が 'Akira'になる  ブロックの最終行なので、処理が終了。
p f.resume('Steve') # FiberErrorが発生します。
```
例2
```
fiber = Fiber.new do
  puts "Start fiber"
  Fiber.yield # 別のFiberに切り替え
  puts "Resume fiber"
end

puts "Before resume"
fiber.resume => "Start fiber"
fiber.resume => "Resume fiber"
puts "After resume"
```

## %記法
`%//` ダブルクォート文字列

`%r//` 正規表現

`%w//` 要素が文字列の配列

## initialize
可視性はprivateになっている publicにしても、必ずprivateになること

```
class C 
public
  def initialize
  end
end

C.new.public_methods.include? :initialize => false
```

## ::演算子
`::`があると、トップレベルから定数の探索を行います。

モジュールMにある`::C`はトップレベルにあるものをさすので、greetメソッドの`CONST`はクラスCにはない

Baseを継承しているので、そこにある定数`CONST`を出力する
```
class Base
  CONST = "Hello, world"
end

class C < Base
end

module P
  CONST = "Good, night"
end

class Base
  prepend P
end

module M
  class C
    CONST = "Good, evening"
  end
end

module M
  class ::C
    def greet
      CONST
    end
  end
end

p C.new.greet => "Hello World"
```

## instance_eval
引数に文字列を指定すると、ネスト状態は特異クラスとなる

```
module M
  CONST = "Hello, world"
end

M.instance_eval(<<-CODE)
  def say
    CONST
  end
CODE

p M::say => "Hello World"
```

ブロックであれば、ネストは定義された場所のネスト。文字列であれば、レシーバのコンテキストで評価
```
m = Module.new

m.instance_eval do
  m.instance_variable_set :@block, Module.nesting
end

m.instance_eval(<<-EVAL)
  m.instance_variable_set :@eval,  Module.nesting
EVAL

block = m.instance_variable_get :@block
_eval = m.instance_variable_get :@eval

puts block.size => 0
puts _eval.size => 1
```

## arg
キーワード引数のこと。省略できないので注意
```
def foo(arg:)
  puts arg
end

foo arg: 100 # このように引数を渡すことが絶対
```
下記のコードでは、`ArgumentError: missing keyword: arg`となる
```
def foo(arg:)
  puts arg
end

foo 100 => エラーになる
```

## freeze
オブジェクトの破壊的変更を禁止する

配列の場合、配列と配列の要素に`freeze`を使用しないと破壊的変更が可能になる
```
ary = ["a", "b", "c"].freeze # 配列に対して使用している

ary.each do |n|
  n.upcase!
end

p ary => ["A", "B", "C"]
```

## Lazyクラス
### lazyメソッド
`map` `select`メソッドに遅延評価を提供する

takeが実行されると、1から3まで`map`に渡されたと判断し、`inject`に渡される。
```
p (1..10).lazy.map{ |num| 
 num * 2
 }.take(3).inject(0, &:+) => 12
```

## Objectクラス
様々なクラスのスーパークラス

### inspect
それぞれのクラスでオーバーライドされているため、それぞれの型に沿った適切な文字列が返される。

標準出力の`p`メソッドはinspectを用いて出力される
```
class Hoge
  def initialize
    @fizz = "bazz"
  end
end

puts Hoge.new.inspect
puts Hoge.new
puts Hoge.new.to_s
p Hoge.new  # inspectと同じ結果が出力される。
print Hoge.new
```

## マーシャリング
オブジェクトをファイルやDBなどに保存できる形式に変換、または変換を戻すこと。

オブジェクト(IO,File,Dir,Socket)や特異メソッド、無名のクラスやモジュールはマーシャリングできない。