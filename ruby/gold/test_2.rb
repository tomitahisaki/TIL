# a, *b = [1, 2, 3]
# p a
# p b

# module M
  # def foo
  #  puts Foo::Const
  # end
#  end
#  class Foo
  # Const = "foo"
  # include M
#  end
#  Foo.new.foo #=> foo

# class Foo
#   def foo
#    "foo"
#   end
#  end


#  class Bar < Foo
#   def foo
#    super + "bar"
#   end
#   alias bar foo
#   undef foo
#  end
#  puts Bar.new.bar #=> foobar 
## aliasとundef順が逆だと、nomethoderrorになる

# CONST = "message1"
#  class Foo
#   CONST = "message2"
#   def foo
#    puts ::CONST
#   end
#  end
#  Foo.new.foo

# class Foo
  # private
  # def foo
  #  puts "foofoofoo"
  # end
#  end
#  puts Foo.new.respond_to?(:foo)

# class Bar
#   def foo
#     puts "barbarbar"
#   end
# end
# class Foo < Bar
#   def initialize(obj)
#     obj.foo
#   end
#   def foo
#     puts "foofoofoo"
#   end
# end
# Foo.new(Foo.new) #=> 再帰的な生成となるので、無限ループとなりエラーが発生する
# Foo.new(Bar.new) #=> "barbarabar"
# Foo.new(Foo.new(Bar.new)) #=> ""

# class Foo
#   attr_reader :var

#   @var = "1"

#   def initialize
#     @var = "2"
#   end
# end

# class Baz < Foo
#   def self.var
#     @var
#   end
# end

# def Foo.var
#   @var
# end

# arr = [
#   Foo.new.var,
#   Foo.var,
#   Baz.new.var,
#   Baz.var
# ]

# p arr

# class Foo
#   CONST = 'Foo'
# end

# CONST = 'Object'

# class Bar < Foo
#   p CONST               # => "Foo"
# end

# # 以下のように明示的にネストしていれば規則通り Object の定数
# # (ネストの外側)が先に探索される
# class Object
#   class Bar < Foo
#     p CONST             # => "Object"
#   end
# end

# def hoge(*args, &block)
#   block.call(*args)
# end

# hoge(1,2,3,4) do |*args|
#   p args
#   p args.length > 0 ? "hello" : args
# end

# *args = "a","b","c","d"
# p args

# module M
#   @@val = 75

#   class Parent
#     @@val = 100
#   end

#   class Child < Parent
#     @@val += 50
#   end

#   if Child < Parent
#     @@val += 25
#   else
#     @@val += 30
#   end
# end

# p M::Child.class_variable_get(:@@val)
# p M.class_variable_get(:@@val)
# p M::Parent.class_variable_get(:@@val)

# class S
#   def initialize
#     puts "S#initialize"
#   end
# end

# class C < S
#   def initialize(*args)
#     super()
#     puts "C#initialize"
#     p args #=> [1,2,3,4,5]
#     p *args #=>1,2,3,4,5
#   end
# end

# C.new([1,2,3,4,5])

# a, b, *c = ["apple", "banana", "carrot", "daikon"]

# p *c #=> carrot, daikon
# p c #=> ["carrot", "daikon"]

# def fx(*args)
#   p(args)
# end
# fx(["apple", "banana", "carrot"])

# def fx(*args)
#   p(*args)
# end
# fx("apple", "banana", "carrot")

# module K
#   CONST = "Good, night"
#   class P
#   end
# end

# module K::P::M
#   class C
#     CONST = "Good, evening"
#     p Module.nesting
#   end
# end

# module M
#   class C
#     CONST = "Hello, world"
#     p Module.nesting
#   end
# end

# class K::P
#   class M::C
#     p CONST
#     p Module.nesting
#   end
# end
# nesting で確かめてみるとネスト関係がわかるので定数探索がわかりやすくなる

# def hoge(*args, &block)
#   block.call(*args) 
# end

# hoge(1,2,3,4) do |*args|
#   p args # => [1,2,3,4]
#   p *args # => 1,2,3,4
#   p args.length > 0 ? "hello" : args
# end

# def hoge(*args, &block)
#   block.call(args) #=> 可変長引数で受け入れない場合
# end

# hoge(1,2,3,4) do |*args|
#   p args # => [[1,2,3,4]]
#   p *args # => [1,2,3,4]
#   p args.length > 0 ? "hello" : args
# end

# def hoge(*args, &block)
#   block.call(args)
# end

# hoge(1,2,3,4) do |args|
#   p args #=> [1,2,3,4]
#   p *args #=> 1,2,3,4
# end
# def fx(*args)
  # p(*args)
# end
# fx(["apple", "banana", "carrot"])

# args = [1,2,3,4]
# def f(*args)
#   p args
# end
# f(*args)

# h = {a:1, b:2, c:3}
# p h.map{_2*10}
# p h.map{|k,v| v*10}
# p h.transform_values{ _1*10}
# p h.transform_values{|v| v*10}

# def bar(test)
#   p test
# end

# def foo(a)
#   bar(a)
# end

# foo(["Ruby Silver!", "Ruby Gold!"]) 

# class Hoge
 
#   def func
#     self.protected_say_hello # OK
#     self.private_say_hello   # OK
#   end
 
#   private
#     def private_say_hello
#       p 'private Hello!'
#     end
 
#   protected
#     def protected_say_hello
#       p 'protected Hello!'
#     end
# end
 
# Hoge.new.func

# class Hoge
 
#   def func
#     other_hoge = Hoge.new
#     other_hoge.protected_say_hello # OK
#     other_hoge.private_say_hello   # NG
#   end
 
#   private
#     def private_say_hello
#       p 'private Hello!'
#     end
 
#   protected
#     def protected_say_hello
#       p 'protected Hello!'
#     end
# end
 
# Hoge.new.func

# add = define_method(:add) do |x,y|
#   x + y
# end

# p add(1, 2)

# def hoge(*args, &block)
  # p *args
  # p args
  # block.call(args)
# end
# 
# hoge(1,2,3,4) do |*args|
  # p args
  # p *args
  # p args.length > 0 ? "hello" : args
# end

# a = [1,2,3,4,5,6,7]
# p a[2..]

# a, b, *c = ["apple", "banana", "carrot", "daikon"] 
# p *c
# def greeting
#   begin
#     "hello"
#   ensure
#     puts "Ensure called!"
  
#     "hi"
#   end
# end
# puts greeting

# class MyError2 < Exception; end

# begin
#   raise MyError2
# rescue => e
#   puts "Exception!!"
# end
# puts "End"

# class MyError1 < StandardError; end

# begin
#   raise MyError1
# rescue => e
#   puts "StandardError!!"
# end
# puts "End"

# module M
#   A = 1
# end
# class C 
#   include M
# end
# class B < C
#   # Bにない → Cにない → Mにあった。
#   p A # => 1
# end

# tel = "0123-0023-789"
# p tel.match(/0.23-?+/)[0]


# f = Proc.new{|str| puts str}
# p f.arity
# f.call("NG")
# f = Proc.new{|i| puts i}
# f.call(1)
# def m
#   begin
#    puts "begin"
#    1
#   ensure
#    puts "ensure"
#    2
#   end
#  end
#  p m

#  def greeting
#   "hello"
# ensure
#   puts "Ensure called!"

#   "hi"
# end

# puts greeting

# class Hoge
#   @hoge = 123
#   def hoge
#     @hoge = 234
#   end
#   class << Hoge
#     @hoge = 345
#     def hoge
#       @hoge
#     end
#   end
# end

# p Hoge.new.hoge #=> 234
# p Hoge.hoge #=> 123
# class << Hoge
#   p @hoge
# end #=> 345

# class Foo; end
# foo1 = Foo.new
# foo2 = Foo.new

# # 特異メソッドは特定のインスタンスだけで使える
# def foo1.foo1_method; 'foo1' end
# p foo1.foo1_method #=> "foo1"
# # foo2.foo1_method #=> NoMethodError

# # 特異クラスのインスタンスメソッドとして実装される
# Foo1Singleton = class << foo1; self; end
# p Foo1Singleton.instance_methods(false) #=> [:foo1_method]

# # extendすると特異クラスにincludeしたことになる
# module Bar; end
# foo1.extend(Bar)
# p Foo1Singleton.ancestors #=> [Bar, Foo, Object, Kernel, BasicObject] 

# module MyModule
#   def self.included(object)
#     p "#{object} has included #{self}"
#   end
# end

# class MyClass
#   include MyModule
# end
# $o =self
# class MyClass
#   $a = self
#   def b
#     $b = self
#   end
# end
# $c = MyClass.new
# # p $a
# # p $o
# p $b = MyClass.new.b
# p $c.b
# # p $a == $o
# p $b == $c
# class C
  # def public_method
    # self.private_method
  # end
# 
  # private
  # def private_method; end
# end
# p C.new.public_method # nil

# class MyClass
#   private
#   def my_private_method
#     puts "private method"
#   end
# end

# obj = MyClass.new()
# # obj.my_private_method # privateメソッドを外部からは呼べない

# # sendを使うと呼べる
# obj.send(:my_private_method)

# inc = lambda {|x| x + 1}
# inc.class
# p inc.call(6) # =>7

# inc = proc {|x| x + 1}
# inc.class
# p inc.call(7) # =>8

CONST = "abc"
def method_a; p CONST; end
def method_b; p CONST = ""; end
def method_c; p CONST += "def"; end
def method_d; p CONST << "hij"; end

method_a
method_b
method_c
method_d