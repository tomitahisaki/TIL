# 再受験のための勉強
## 例外処理
Exceptionを継承したエラーは捕捉されない

明記すれば、補足される
```
class MyError2 < Exception; end

begin
  raise MyError2
rescue => e
  puts "Exception!!"
end
puts "End"
# MyError2
```

StandardErrorを継承したエラー捕捉される
```
class MyError1 < StandardError; end

begin
  raise MyError1
rescue => e
  puts "StandardError!!"
end
puts "End"

#=> StandardError!!
#=> End
```

### 指定しない場合はRunTimeErrorとなる
`rescue`に特定の例外クラスをいれないと、StandardErrorとそのサブクラスが捕捉される

デフォルトは`RunTimeError`となる
```
begin
  raise
rescue => e
  p e.class # RunTimeError
  puts "OK"
end
```
継承には気をつけること `Err1`を`resuce`するが、サブクラスが存在しているので、サブクラスが出力される
```
class Err1 < StandardError; end
class Err2 < Err1; end
begin
  raise Err2
rescue Err1 => e
  p e.class
end
# Err2
```

### ensureの処理
`ensure`が先に評価されてから通常処理が返される。

ただし、下記のように`begin`に`puts "begin"`のような処理があると、そちらが優先される。通常処理として出力 `ensure`の`puts "ensure"`も同じことが言える

その後 `ensure`部分が出力されず、再度`begin`の`1`が出力
```
def m
  begin
   puts "begin"
   1
  ensure
   puts "ensure"
   2
  end
end
p m
# begin
# ensure
# 1

def greeting
    "hello"
  ensure
    puts "Ensure called!"

    "hi"
end
puts greeting
# Ensure called!
# hello

これが一番わかり易いたとえ？
def greeting
    "hello"
  ensure
    "hi"
end
put greeting
"hello"
```

`ensure`と`else`がある場合、出力は`else`が優先される。ensureも実行されているが、評価としては無視される。
```
def m
  begin
    1
  rescue
    2
  else
    3
  ensure
    4
  end
end

p m #=> 3
```

## splat演算子
```
def hoge(*args, &block)
  p *args #=> 1,2,3,4
  p args #=> [1,2,3,4]
  block.call(args)
end

hoge(1,2,3,4) do |*args|
  p args #=> [[1,2,3,4]]
  p *args #=> [1,2,3,4]
  p args.length > 0 ? "hello" : args
end

```

## 可変長引数
```
*args = 1,2,3,4 # *argsに複数の変数変数を代入する
p *args #=> 1,2,3,4 # *argsとすることで、配列を展開して個別の要素として表示できる 
p args #=> [1,2,3,4]
```

```
def hoge(*args, &block) # 受け取った引数をブロックに展開する。 可変長引数*argとして、配列として受け取る
  block.call(*args) # 各要素を個別の引数として展開する 配列→それぞれ
end
hoge(1,2,3,4) do |*args| # 引数を配列として受け取る
  p args # => [1,2,3,4]
  p *args # => 1,2,3,4
end

def hoge(*args, &block)
  block.call(args) #=> 可変長引数の*argsのargsをそのままブロックに展開する 配列→配列
end
hoge(1,2,3,4) do |*args| #=> 引数を配列として受け取っている。元が配列の場合は２次元配列となる
  p args # => [[1,2,3,4]]
  p *args # => [1,2,3,4]
end

def hoge(*args, &block)
  block.call(args)
end

hoge(1,2,3,4) do |args|
  p args #=> [1,2,3,4]
  p *args #=> 1,2,3,4
end
```

## ナンパラ
下記は全て同じvalueが出力される
```
h = {a:1, b:2, c:3}
p h.map{_2*10} # => [10, 20, 30]
p h.map{|k,v| v*10} # => [10, 20, 30]
p h.transform_values{ _1*10 } # => {:a=>10, :b=>20, :c=>30}
p h.transform_values{|v| v*10} # => {:a=>10, :b=>20, :c=>30}
```

配列、ハッシュでも使えた
```
ary = [["a", "gold"], ["b", "silver"]]
puts ary.map{ "#{_1}: #{_2}"}
# => a: gold
# => b: silver

hash = {a: "gold", b: "silver"}
puts hash.map{ "#{_1}: #{_2}"}
# => a: gold
# => b: silver
```

値がない場合は、出力されていないことを確認
```
h1 = [1,2,3,4]
h1.map {puts "key:#{_1}, value: #{_2}"}
#=> key:1, value:
#=> key:2, value:
#=> key:3, value:
#=> key:4, value:
```

多次元配列のときの`_1`は配列自体を見ている可能性がある

`_1 * 10`としても配列に対して行われているので注意
```
p [[1, "Foo"], [2, "bar"], [3, "baz"]].map { _2.upcase } # ["FOO", "BAR", "BAZ"]
p [[1, "Foo"], [2, "bar"], [3, "baz"]].map { _2 } # ["Foo", "bar", "baz"]
p [[1, "Foo"], [2, "bar"], [3, "baz"]].map { _1 } # [[1, "Foo"], [2, "bar"], [3, "baz"]]
p [[1, "Foo"], [2, "bar"], [3, "baz"]].map { |n, v| n * 10 } # [10, 20, 30]
p [[1, "Foo"], [2, "bar"], [3, "baz"]].map { _1 * 2 } # [[1, "Foo", 1, "Foo"], [2, "bar", 2, "bar"], [3, "baz", 3, "baz"]]
```


## 転送引数
引数を転送する記法

```
def bar(test)
  p test
end

def foo(...)
  bar(...)
end

foo(["Ruby Silver!", "Ruby Gold!"]) 
```
使わないときは下記の形
片方だけ指定すると`SyntaxError`となる
```
def bar(test)
  p test
end

def foo(a) 
  bar(a)
end

foo(["Ruby Silver!", "Ruby Gold!"]) 

def bar(test)
  p test
end

def foo(a) 
  bar(...)
end

foo(["Ruby Silver!", "Ruby Gold!"])  # SyntaxError

```

引数をいくつか指定し、残りを転送引数に渡しても良い
```
def bar(n, a)
  puts a + n
end

def foo(n, ...)
  bar(n, ...)
end

foo(1,2)
```

可変長引数とハッシュ、オプション引数のような受渡しもできる
```
def bar(*ary, key: "default", **params)
  p key
  p ary
  p params
end

def foo(...)
  bar(...)
end

foo(*[1,2,3], key: "value", broodtype: "o")
```
極論、こういうことも可能！
```
def foo(a, b, c = 3, d = 4, *ef, g, h, i: 9, j: 10, **kl, &m)
  "a: #{a}, b: #{b}, c: #{c}, d: #{d}, ef: #{ef}, g: #{g}, h: #{h}, i: #{i}, j: #{j}, kl: #{kl}, h: #{m}"
end

def bar(...)
  foo(...)
end

p bar(1, 2, 3, 4, 5, 6, 7, 8, i: 9, j: 10, k: 11, l: 12,){ 13 }
# "a: 1, b: 2, c: 3, d: 4, ef: [5, 6], g: 7, h: 8, i: 9, j: 10, kl: {:k=>11, :l=>12}, h: #<Proc:0x000000010472c928 test_2.rb:1547>"
```

## protected private
レシーバありでも、内部で異なるインスタンスでも呼び出せるのが`protected`の特徴
```
class Hoge
 
  def func
    other_hoge = Hoge.new
    other_hoge.protected_say_hello # OK
    other_hoge.private_say_hello   # NG
  end
 
  private
    def private_say_hello
      p 'private Hello!'
    end
 
  protected
    def protected_say_hello
      p 'protected Hello!'
    end
end
 
Hoge.new.func
```

レシーバ(self)ありであれば、どちらも可能
```
class Hoge
  def func
    self.protected_say_hello # OK
    self.private_say_hello   # OK
  end
  private
    def private_say_hello
      p 'private Hello!'
    end
  protected
    def protected_say_hello
      p 'protected Hello!'
    end
end
```

### privateをsuperで呼べる？
サブクラスでsuperで定義しても呼べる。
```
class Hoge
  private
  def private_in_hoge
    puts "in private"
  end
end

class Foo < Hoge
  def private_in_hoge
    super
  end
end

Foo.new.private_in_hoge # in private
```

privateメソッドは外部から呼べないが、sendを使った動的呼び出しには反応する
```
class MyClass
  private
  def my_private_method
    puts "private method"
  end
end

obj = MyClass.new()
# obj.my_private_method # privateメソッドを外部からは呼べない

# sendを使うと呼べる
obj.send(:my_private_method)
```

### aliasでもprivateを呼べる
```
class Foo
  private
  def private_in_superclass
    "private in superclass"
  end
end

class Biz < Foo
  alias superclass_method private_in_superclass
  def private_in_superclass 
    superclass_method
  end
end
p Biz.new.private_in_superclass # => "private in superclass"
```

### privateのクラスメソッドとインスタンスメソッドを呼んでみた
```
class A
  def self.foo
    self.bar
  end

  def fiz
    bar
  end

  private
  def bar
    "instance"
  end

  def self.bar
    "class1"
  end
end
puts A.foo # => "class1" ## privateメソッドを呼んでいるように見えるが、多分クラスメソッドはprivateにできない
puts A.new.fiz # => "insance"
```

### サブクラスでprotectedとprivateを使う
```
class Foo
  private
  def private_method1
    puts "private_method1"
  end

  def private_method2
    puts "private_method2"
  end

  protected
  def protected_method1
    puts "protected_method1"
  end

  def protected_method2
    puts "protected_method2"
  end
end

class Baz < Foo
  public :private_method2, :protected_method2
  def public_method_from_private
    private_method1
  end

  def public_method_from_protected
    protected_method1
  end
end
## superclassで定義したprivate protectedのどちらのメソッドも呼び出し可能
Baz.new.public_method_from_private
Baz.new.private_method2
Baz.new.public_method_from_protected
Baz.new.protected_method2
```

## グローバル変数

```
$o =self
class MyClass
  $a = self
  def b
    $b = self #=> インスタンスメソッドなので、インスタンスが処理されるごとに$bの中身も変わることに注意！ そして、処理がされない限り $bには何も入らないこと！
  end
end
$c = MyClass.new
p $a # MyClass
p $o # main
p $b # nil メソッドが発動しない限り、nil
p $c # MyClassのインスタンス
p $c.b # $bにself($cのこと)が入るので、$cのインスタンスと等しくなる

p $a == $o #=> false
p $b == $c #=> true
```

## 定数
定数の初期化について
メソッド内で定数を定義したり、破壊的な変更はできない。
```
CONST = "abc"
def method_a; p CONST; end
def method_b; p CONST = ""; end  # => dynamic constant assignment
def method_c; p CONST += "def"; end  # => dynamic constant assignment
def method_d; p CONST << "hij"; end

method_a
method_b  # => 定義段階でエラー
method_c  # => 定義段階でエラー
method_d  # => 破壊的メソッドではない
```

### 呼び出し方

```
A = 10
module M 
  A = 1
  class B
    A = 2
  end
  class C
    def const
      A
    end

    def const_b
      B::A
    end
    
    def const_top
      ::A
    end
  end
end

p M::A # 1
p M::B::A # 2
p M::C.new.const # 1
p M::C.new.const_b # 2
p M::C.new.const_top # 10
```

## 文法

配列の作成方法によっては、同じオブジェクトIDをもつ
```
ary = Array.new(3){"a"}
ary_1 = Array.new(3,"a")
ary[0].next!
ary_1[0].next!
p ary # ["b", "a", "a"]
p ary_1 # ["b", "b", "b"]
```

## クラス変数とクラスインスタンス変数の違い
```
class A
  @@a = 1
  @b = 2
  # p @@a #=> 1
  # p @b #=> 2
  class << self
    @@a = 10
    @b = 20
    # p @@a #=> 10
    # p @b #=> 20
  end
end
puts A.singleton_class.instance_variable_get(:@b) # 20
puts A.singleton_class.class_variable_get(:@@a) # 10
puts A.instance_variable_get(:@b) # 2 クラスインスタンス変数は、共有されないので、#AクラスとAクラスのクラスインスタンス変数は異なる。
puts A.class_variable_get(:@@a) # 10 こちらは再代入されているから 1は出力されない

p singleton_variable = class << A
                          @b #=> 特異クラスで定義したインスタンス変数を表示する方法
                       end
```

こちらでもわかりやすい
```
class Speaker
  @message = "Hello!"

  class << self
    @message = "Howdy!"

    def speak
      @message
    end
  end
end

puts Speaker.speak # Hello!
# puts Speaker.singleton_class.speak # 特異クラスでのNoMethodError Speakerの特異クラスのスーパークラスで、定義していないから！
puts Speaker.instance_variable_get(:@message) # Hello!
puts Speaker.singleton_class.instance_variable_get(:@message) # Howdy
```

### クラス変数はサブクラスまで共有している結果
このような出力で確認するとわかる
```
class A
  puts "a"
  @@x = 0
  class << self
    puts "b"
    @@x = 1
    def x 
      puts "c"
      @@x
    end
  end
  def x 
    puts "d"
    @@x = 2
  end
end

class B < A
  puts "e"
  @@x = 3
end
p A.x   #=> a b e c 3
# dはインスタンスメソッド内なので、出力されない
```

## undef
メソッドを未定義にして呼び出せなくする。 サブクラスで未定義にした場合は、 呼び出せなくなる

親クラスのメソッドには影響しないものの、未定義にすることで、親クラスの同名メソッドも呼び出せない
```
class Bar < Foo
 def foo
  super + "bar"
 end
 alias bar foo
 undef foo
end
puts Bar.new.bar #=> foobar 
aliasとundef順が逆だと、nomethoderrorになる
```
使うと呼び出したクラスとサブクラスでメソッドを呼び出せなくなる。
```
class C
  def func; puts "Hello"; end
end

class Child < C
  undef_method :func
end

class GrandChild < Child
end

C.new.func # => Hello
# Child.new.func # => NoMethodError
# GrandChild.new.func # => NoMethodError
```

## remove_method
undef とは異なる。メソッドを削除する。削除できるのは、親クラスの同名メソッドは削除しない。

そのため、削除したメソッドと同名メソッドが親クラスにある場合は、そちらが呼ばれるようになる
```
class C
    def f; puts "World"; end
end

class Child < C
    def f; puts "Hello"; end
end

child = Child.new
puts child.f # Hello

Child.class_eval { remove_method :f }

puts child.f # World
```

## ブロックを渡すには
転送引数を使っている。使わない場合は、`$block`を明示すること
```
def sample_a(...)
  if block_given?
    puts 'Yes:a'
  else
    puts 'No:a'
  end
  sample_b(...)
end

def sample_b(&block)
  if block_given?
    puts 'Yes:b'
    block.call
  else
    puts 'No:b'
  end
end

sample_a { puts 'I am a block' }
# Yes:a
# Yes:b
# I am a block
```

## append_features
いつ読み込まれているのかと、superを書かないと読み込まれない

```
module M
  def self.append_features(klass)
    p klass.ancestors #=> [C, Object, Kernel, BasicObject]
    super # このsuperを書かないと読み込まれない。
    p klass.ancestors #=> [C, M, Object, Kernel, BasicObject]
  end
  
  def func
    p "Hello World"
  end
end

class C
  include M
end
p C.ancestors #=> [C, M, Object, Kernel, BasicObject]
```

## 自己代入
```
def count
  @count ||= 0
  puts "#{@count}"
  @count += 1
end

count # 0
count # 1
count # 2
count # 3
```

## singleton
こんな形で出力するとわかりやすい 
```
require "singleton"

class Foo
  include Singleton
end

p x = Foo.instance #=> #<Foo:0x00000001025fe198>
p y = Foo.instance #=> #<Foo:0x00000001025fe198>
```

## strptime iso8601を使ってみる
```
require "time"

t = Time.strptime("00000024021993", "%S%M%H%d%m%Y")
puts t #=> 1993-02-24 00:00:00 +0900
puts t.iso8601 #=> 1993-02-24T00:00:00+09:00
```

## Date DateTime
```
require "date"

date = Date.new(2000, 2, 24)
datetime = DateTime.new(2000, 2, 24)

puts(date << 12) #=> 1999-02-24
puts(date >> 12) #=> 2001-02-24
puts(datetime << 12) #=> 1999-02-24T00:00:00+00:00
puts(datetime >> 12) #=> 2001-02-24T00:00:00+00:00
```

## パターンマッチ
hashで行う
```
h = {a: 1, b: 2, c: 3}
case h
in {a: a, d: d} # dはないので、出力されない
  p "a: #{a}, d: #{d}"
in {a: a, b: b, c: c} # こちらが出力
  p "a: #{a}, b: #{b}, c: #{c}"
end
```
### 気をつけるポイント
```
h = {a: 1, b: 2, c: 3}
case h
in {a: a, b: b} # こちらが出力される。cはないが、出力された
  p "a: #{a}, b: #{b}"
in {a: a, b: b, c: c} 
  p "a: #{a}, b: #{b}, c: #{c}"
end

```
配列
```
h = [1, 2, 3]
case h
in [x, y]
  p [:two, x, y]
in  [x, y, z] # 要素数がマッチするので、出力される
  p [:three, x, y, z]
end
```

## キーワード引数
仮引数でデフォを設定していれば良いが、指定せずに引数を渡さないとエラーになる
```
def fx(a:, b: "apple")
  p a
  p b
end

fx(a: "banana")
```

## 半無限区間
`..`をつかうことでつけられる

下記の下２行は以下と未満の意味なので注意！
```
a = [1,2,3,4,5,6]
p a[3..5] #=>[4,5,6]
p a[3,3] #=>[4,5,6]
p a[3..-1] #=>[4,5,6]
p a[-3..-1] #=>[4,5,6]
p a[3..] #=>[4,5,6]
p a[..2] #=>[1,2,3]
p a[...2] #=>[1,2]
```

## dup clone違い
お互いにシャローコピーなので、自身の複製は可能。参照先のコピーはしていない

なので、`object_id`は異なる
```
a = "hoge"
b = a.dup
p a.object_id
p b.object_id
puts "------------------------------"
c = "foo"
d = c.clone
p c.object_id
p d.object_id
```
特徴としては、`clone`のほうが複製項目が多い。汚染状態(taint),インスタンス変数,ファイナライザはどちらも複製するが、

加えて凍結状態(freeze),特異メソッドもコピーできる

```
obj = "string"
def obj.hoge
  puts "hello world"
end
obj.freeze
obj_dup = obj.dup
p obj_dup.frozen? # false
# p obj_dup.hoge ## nomethoderror 

obj_clone = obj.clone 
p obj_clone.frozen? # true
p obj_clone.hoge # hello world
```

## class_evalとinstance_evalをクラス内で定義すると
```
class Stack
  def initialize
    @contents = []
  end

  [:push, :pop].each do |name|
    instance_eval(<<-EOF)
      def #{name}(*args)
        @contents.send(:#{name}, *args)
      end
    EOF
  end
end
p Stack.instance_methods #  class_evalを使用すると、インスタンスメソッドに追加されるので、こちらに表示される
p Stack.methods # instance_evalをクラス内で使用すると、特異メソッド定義となるので、こちらに追加される
```

## class_eval
インスタンスメソッドを定義可能。インスタンスにたいして行うとエラーとなる

`A.class_eval`を`m.class_eval`とすると特異メソッドになるので、インスタンスメソッドとして使えない

定数の探索順位もわかった。
```
class A; end
m = A.new

CONST = "Constant in Toplevel"

_proc = Proc.new do
  CONST = "Constant in Proc"
end

A.class_eval(<<-EOS)
  CONST = "Constant in Module instance"

  def const
    CONST
  end
EOS

A.class_eval(&_proc)

p m.const
# コメントアウトしてくと分かったこと
# 優先順位1: "Constant in Module instance"
# 優先順位2: "Constant in Proc"
# 優先順位3: "Constant in Toplevel"
```

## instance_eval
メソッドを定義するときは、インスタンスに対して行うこと! 特異メソッドを定義する

レシーバの部分をクラスにしても、インスタンスメソッドを生成しない。

定数の探索順位は、class_evalと同様
```
class A; end
m = A.new

CONST = "Constant in Toplevel"

_proc = Proc.new do
  CONST = "Constant in Proc"
end

m.instance_eval(<<-EOS)
  # CONST = "Constant in Module instance"

  def const
    CONST
  end
EOS

A.instance_eval(&_proc)

p m.const
```

## catch throw
基本的に、`throw :exit [x, y]`としたいが、下記のような脱出構文でもエラーは発生しなかった。

```
# a, b = catch :exit do
  # for x in 1..10
    # for y in 1..10
      # return [x, y] if x + y == 10
    # end
  # end
# end

# a, b = catch :exit do
  # for x in 1..10
    # for y in 1..10
      # break [x, y] if x + y == 10
    # end
  # end
# end

# a, b = catch :exit do
  # for x in 1..10
    # for y in 1..10
      # next [x, y] if x + y == 10
    # end
  # end
# end
```

## Proc 渡し方について
Procは、callもしくは[]で呼び出される

`foo[2]`の場合は、Procが先に呼び出される

`foo(2)`の場合は、メソッドが選択される

```
def foo(n)
  n ** n
end

foo = Proc.new { |n|
  n * 3
}

puts foo(2) * 2 #=> 8
puts foo[2] * 2 #=> 12
puts foo [2] * 2 #=> 12
puts foo (2) * 2 #=> 256
puts foo 2 * 2 #=> 256
```

## 正規表現
```
p "Bibbidi-Bobbidi-Boo".match(/B.bbidi-?+/)  #=> #<MatchData "Bibbidi-">
p /B.bbidi-?+/.match("Bibbidi-Bobbidi-Boo")  #=> #<MatchData "Bibbidi-">
result = /B.bbidi-B.bbidi-/.match("Bibbidi-Bobbidi-Boo")
p result #=> #<MatchData "Bibbidi-Bobbidi-">

p /(B.bbidi-)+/.match("Bibbidi-Bobbidi-Boo") #=> #<MatchData "Bibbidi-Bobbidi-" 1:"Bobbidi-">

p "Bibbidi-Bobbidi-Boo".scan(/B.bbidi-/) #=> ["Bibbidi-", "Bobbidi-"]
```

```
p /a+/.match("aaab") # "aaa" 貪欲マッチング
p /a+?/.match("aaab") # "a"  最小一致 非貪欲マッチング 
p /a?+/.match("aaab") # "a"  意味をなさない構文。結果は最小一致と同じ
```

## 継承 レキシカルスコープ
よく間違える継承について

ネストしている部分は名前空間だけなので、継承しているわけではないことに注意!!

定数を探しているときは、ネストした中も最初に探す。その後で、継承順に探していく！

```
class Ca
  CONST = "001"
end

class Cb
  CONST = "010"
end

class Cc
  CONST = "011"
end

class Cd
  CONST = "100"
end

module M1
  class C0 < Ca
    p self.ancestors
    class C1 < Cc
      p CONST # 011
      p self.ancestors
      class C2 < Cd
        p CONST # 100
        p self.ancestors

        class C2 < Cb
        end
      end
    end
  end
end
# => [M1::C0, Ca, Object, Kernel, BasicObject]
# => [M1::C0::C1, Cc, Object, Kernel, BasicObject]
# => [M1::C0::C1::C2, Cd, Object, Kernel, BasicObject]
```

# よく間違えるところ
ネストと継承は異なることに注意すること！
```
module M1
  class C0 < Ca
    p self.ancestors
    class Cd < Cc
      p CONST
      p self.ancestors
      class C2 < Cd
        p CONST
        p self.ancestors

        class C2 < Cb
        end
      end
    end
  end
end
# => [M1::C0, Ca, Object, Kernel, BasicObject]
# => "011"
# => [M1::C0::Cd, Cc, Object, Kernel, BasicObject]
# => "011" このときは、Cdクラスではなく、M1::C0::Cdを継承していることに注意！ 
# => [M1::C0::Cd::C2, M1::C0::Cd, Cc, Object, Kernel, BasicObject]
```

## freeze
`<<`のときは破壊的メソッドになる。idが変化していないことがわかる。

`+=`の場合は、非破壊メソッド。idを見ると、変化しているので、別の変数扱い
```
var = "a".freeze
p var.object_id
 var << "as"
p var.object_id # frozen error

var = "a".freeze
p var.object_id
 var += "as"
p var.object_id 
```

## 複数の引数の定義
複数の引数の場合は、順番に注意！！！

特に通常引数は、オプションハッシュの前に置くとエラーとなる

- 通常の引数
- デフォルト式付き引数
- 可変長引数
- 通常の引数
- キーワード引数
- デフォルト式付きキーワード引数
- オプションハッシュ
- ブロック引数

hについては、Procなので、`h.callにしないと` procオブジェクトが出力されるので気をつける
```
def method(a, b = 1, *c, d, e:, f: 2, **g, &h)
  return a, b, c, d, e, f, g, h
  end
p method(0, 1, 2, 3, e:4, f:5, g:6) { 7 }
```
転送引数も使える！
```
def method(a, b = 1, *c, d, e:, f: 2, **g, &h)
  return a, b, c, d, e, f, g, h
  end

def method_a(...)
  method(...)
end
p method_a(0, 1, 2, 3, e:4, f:5, g:6){ 7 }

```

## Refinement 
厳密なレキシカルスコープで動作する！

```
module Extensions1
  refine String do
    def hello
      puts self + "hello Extensions1"
    end
    def hi
      puts self + "hi Extension1"
    end
  end
end

module Extensions2
  refine String do
    def hello 
      puts self + "hello Extensions2"
    end
  end
end

class RefineTest
  using Extensions1
  "outer1".hello # => outer1 hello Extensions1
  
  class InnerClass
    using Extensions2
    # innerClass内のみで変更が適用される
    "inner".hello # => inner hello Extensions2
    # ネストしていても、Extension1は呼び出し可能
    "outer2".hi # => outer2 hi Extensions1
  end
  
  "outer2".hello # => outer2 hello Extensions1
  "outer2".hi # => outer2 hi Extensions1
end
```


## 引数に気をつける 
initializeが呼ばれたときに、引数のオブジェクトによって処理が開始される際は気をつける

```
class Foo
  def initialize(obj)
   obj.foo
  end
  def foo
   puts "foofoofoo"
  end
 end
 class Bar
  def foo
   puts "barbarbar"
  end
 end
 Foo.new(Bar.new) # barbarbar

class Bar
  def foo
    puts "barbarbar"
  end
end
class Foo < Bar
  def initialize(obj)
    obj.foo
  end
  def foo
    puts "foofoofoo"
  end
end
Foo.new(Foo.new(Bar.new))
# barbarbar
# foofoofoo
```

## moduleをmixinする
`module`の特異メソッド、`class`の特異メソッドとして場合は、下記のようにするとできる

```
module Mixin
  extend self
  def greet
    "Hello World!"
  end
end

class SomeClass
  extend Mixin
end

p Mixin.greet # Hello World!
p SomeClass.greet # Hello World!
```

## return break nextの違い
`return`はメソッドからぬける

`break`はスコープからぬける

`next`処理中断し、次の処理を実行する

```
def foo
  [1,2,3].each do |i|
    break if i == 2
    p i
  end
  p "out of scope within method"
end
foo
# 1
# out of scope within method

def foo
  [1,2,3].each do |i|
    return if i == 2
    p i
  end
  p "out of scope within method"
end
foo
# 1

def foo
  [1,2,3].each do |i|
    next if i == 2
    p i
  end
  p "out of scope within method"
end
foo
# 1
# 3
# out of scope within method
```

## p puts print の違い
よくわかっていない部分

```
class C
  def initialize(str)
    @str = str
  end
  
  def inspect
    "inspect"
  end
  
  def to_s
    "to_s"
  end
  
  def to_str
    "to_str"
  end
end

p C.new ""             # => inspect
p "#{ C.new("") }"     # => "to_s"
p "" + C.new("")       # => "to_str"

puts C.new ""          # => to_s
puts "#{ C.new("") }"  # => to_s
puts "" + C.new("")    # => to_str

print C.new ""         # => to_s
print "#{ C.new("") }" # => to_s
print "" + C.new("")   # => to_str
```

## superの引数

```
class A
  def initialize(*rest)
    puts "*rest=#{rest}"
  end
end

class B < A
  def initialize(first, *rest)
    # 第一引数を表示
    puts "first1=#{first}"
    # 第二引数以降を表示
    puts "rest1=#{rest}"
    # initializeと同じ引数でclass Aのinitializeを呼び出す
    super
    # 明示的に引数なしを指定すると引数なしでclass Aのinitializeを呼び出せる
    super()
  end
end

obj1 = B.new("A","B","C","D","E")

#=> first1=A
#=> rest1=["B", "C", "D", "E"]
#=> *rest=["A", "B", "C", "D", "E"]
#=> *rest=[]
```

## newメソッドの定義位置
Classクラスのインスタンスでは、Classクラスのインスタンスメソッドの`new`を使用します。

StringはClassクラスのインスタンスなので、Classのインスタンスメソッドを使う
```
p Class.method_defined? :new #=> ture
p String.method_defined? :new #=> false
p Class.singleton_class.method_defined? :new #=> ture
p String.singleton_class.method_defined? :new #=> ture
```

## クラスメソッドとインスタンスメソッドの確認
```
class Foo
  @@var = 1
  def self.class_method
    @@var
  end
  def instance_method
    @var = 1
  end
end

# インスタンスオブジェクトを参照
foo = Foo.new
foo.instance_method
foo.instance_variables # => [:@var]

# クラスを参照
Foo.class_variables # => [:@@var]
Foo.instance_methods(false) # => [:instance_method]
# Fooクラスにはclass_methodsメソッドが存在しない。クラスメソッドは特異クラスに定義される
Foo.class_methods(false) # => NoMethodError: undefined method `class_methods' for Foo:Class
# 特異クラスのメソッドを参照するにはクラスの特異メソッドを確認
Foo.singleton_methods(false) #=> [:class_method]
```
