# 再受験のための勉強
## 正規表現

## 例外処理
Exceptionを継承したエラーは捕捉されない
```
class MyError2 < Exception; end

begin
  raise MyError2
rescue => e
  puts "Exception!!"
end
puts "End"
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

### ensure
begin ある場合は "begin"出力後に`ensure`を評価して出力。その後、1が出力される

beginがない場合、`ensure`が先に評価されてから通常処理が返される。
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
# Ensure called
# hello
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
p h.map{_2*10}
p h.map{|k,v| v*10}
p h.transform_values{ _1*10 }
p h.transform_values{|v| v*10}
```

## 転送引数
引数を転送する記法

転送引数の場合、どちらか片方の引数を指定できないっぽい
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

レシーバありであれば、どちらも可能
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

## グローバル変数

```
$o =self
class MyClass
  $a = self
  def b
    $b = self #=> インスタンスメソッドなので、インスタンスが処理されるごとに$bの中身も変わることに注意！
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

## 文法

配列の作成方法によっては、同じオブジェクトIDをもつ
```
ary = Array.new(3){"a"}
ary_1 = Array.new(3,"a")
ary[0].next!
ary_1[0].next!
p ary
p ary_1
```

## クラス変数とクラスインスタンス変数の違い
```
class A
  @@a = 1
  @b = 2
  p @@a #=> 1
  p @b #=> 2
  class << self
    @@a = 10
    @b = 20
    p @@a #=> 10
    p @b #=> 20
  end
end
p A.class_variable_get(:@@a) #=> 10 クラス変数 共有されるので、再代入となる
p A.instance_variable_get(:@b) #=> 2 インスタンス変数は共有されない
p singleton_variable = class << A
                          @b #=> 特異クラスで定義したインスタンス変数を表示する方法
                      end
```

## undef
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