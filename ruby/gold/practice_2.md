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

p m
```

## splat演算子

## 可変長引数
```
*args = 1,2,3,4 # *argsに複数の変数変数を代入する
p *args #=> 1,2,3,4 # *argsとすることで、配列を展開して個別の要素として表示できる 
p args #=> [1,2,3,4]
```

```
def hoge(*args, &block) # 受け取った引数をブロックに展開する。 引数argとして、出力は配列？
  block.call(*args) # 各要素を個別の引数として展開する 配列→それぞれ
end
hoge(1,2,3,4) do |*args| # ブロック内で引数を個別に受け取るための*args
  p args # => [1,2,3,4]
  p *args # => 1,2,3,4
end

def hoge(*args, &block)
  block.call(args) #=> 可変長引数の*argsのargsをそのままブロックに展開する 配列→配列
end
hoge(1,2,3,4) do |*args| #=> 引数を配列として受け取っている。
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

## グローバル変数
ガーベッジコレクション

```
$o =self
class MyClass
  $a = self
  def b
    $b = self
  end
end
$c = MyClass.new
p $a
p $
p $b = MyClass.new.b
p $c.b
p $a == $o # false MyClassとmainの比較
p $b == $c # true オブジェクト比較はfalseだが、ガーベッジコレクションの関連上、一時的にtrue
```

## 定数
定数の初期化について
メソッド無いで
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