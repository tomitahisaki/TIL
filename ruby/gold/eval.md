# class_eval(module_eval) と instance_eval がわからない

## module_eval
モジュールの評価をして、メソッドを定義する

インスタンス、クラスメソッドともに定義できる。変数も可能

### 文字列で定義してみる
文字列で定義した場合、違いがクラス変数を呼ぶことが可能

インスタンスメソッド、クラスメソッドも定義している
```rb
class Foo
  def initialize
    @x = 1
  end
end

Foo.class_eval(<<EOL)
  @y = 2
  @@a = 3
  def output
    @x
  end
  def greet
    "hello instance_method"
  end
  def self.hi
    "hi class_method"
  end
EOL

foo = Foo.new
puts foo.instance_variables # => @x
puts Foo.instance_variables # => @y
puts Foo.class_variables # => @@a
puts foo.output # => 1
puts Foo.instance_methods.grep(/output/) # => output
puts foo.greet #=> "hello instance_method"
puts Foo.hi #=> "hi class_method"
```

### ブロックで定義してみる
クラス変数は、エラーが発生した。
```
class variable access from toplevel (RuntimeError)
```
単純に、下記のように書くと、トップレベルと同じスコープになるので、エラーが発生した。
```rb
class Foo
  def initialize
    @x = 1
  end
end

Foo.class_eval do
  @y = 2
  # @@a = 3
  def output
    @x
  end
  def greet
    "hello instance_method"
  end
  def self.hi
    "hi class_method"
  end
end

foo = Foo.new
puts foo.instance_variables # => @x
puts Foo.instance_variables # => @y
# puts Foo.class_variables # => class variable not Toplevel
puts foo.output # => 1
puts Foo.instance_methods.grep(/output/) # => output
puts foo.greet # => hello instance_method
puts Foo.hi # => hi class_method
```

## instance_eval
### ブロックで定義してみる
インスタンスメソッドを定義できなくなる 特異メソッドのみが定義可能。インスタンス変数は定義できる

```rb
class Foo
  def initialize
    @x = 1
  end
end

Foo.instance_eval do
  @y = 2
  # @@a = 3
  def output
    @x
  end
  def greet
    "hello instance_method"
  end
  def self.hi
    "hi class_method"
  end
end

foo = Foo.new
puts foo.instance_variables # => @x
puts Foo.instance_variables # => @y
# puts Foo.class_variables # => class variable not Toplevel
# puts foo.output # => NoMethodError
puts Foo.instance_methods.grep(/output/) # => なし インスタンスメソッドを定義していない
# puts foo.greet # => NoMethodError
puts Foo.hi # => hi class_method
```

### 文字列で定義してみる
```rb
class Foo
  def initialize
    @x = 1
  end
end

Foo.instance_eval(<<EOL)
  @y = 2
  # @@a = 3
  def output
    @x
  end
  def greet
    "hello instance_method"
  end
  def self.hi
    "hi class_method"
  end
EOL

foo = Foo.new
puts foo.instance_variables # => @x
puts Foo.instance_variables # => @y
# puts Foo.class_variables # => class variable not Toplevel
# puts foo.output # => NoMethodError
puts Foo.instance_methods.grep(/output/) # => なし インスタンスメソッドを定義していない
# puts foo.greet # => NoMethodError
puts Foo.hi # => hi class_method
```
