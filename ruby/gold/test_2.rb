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
#   p *args
#   p args
#   block.call(args)
# end

# hoge(1,2,3,4) do |*args|
#   p args
#   p *args
#   p args.length > 0 ? "hello" : args
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
# class MyError2 < MyError1; end

# begin
#   raise MyError2
# rescue => e
#   puts e.class
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
# p f.arity  # 1
# f.call("NG") # NG
# f = Proc.new{|i| puts i}
# f.call(1) # 1

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
  # include MyModule
# end

# $o =self
# class MyClass
  # $a = self
  # def hoge
    # $b = self
  # end
# end
# c = MyClass.new
# p $a #=> MyClass
# p $o #=> main (Objectクラス)
# p $b == c # false
# c.hoge # $b にオブジェクトの情報が入る
# p $a == $o # false
# p $b == c #=> true


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

# CONST = "abc"
# def method_a; p CONST; end
# def method_b; p CONST = ""; end
# def method_c; p CONST += "def"; end
# def method_d; p CONST << "hij"; end

# method_b
# method_a
# method_c
# method_d

# module M
  # def self.greet
    # puts "Hello World!"
  # end
# end
# 
# class SomeClass
  # include M
# end
# M.greet
# SomeClass.greet

# def hoge(*args)
  # p args
# end
# hoge([1,2,3])

# class Foo
#   private
#   def private_in_superclass
#     "private in superclass"
#   end
# end

# class Biz < Foo
#   alias superclass_method private_in_superclass
#   def private_in_superclass 
#     superclass_method
#   end
# end
# p Biz.new.private_in_superclass
# ary = Array.new(3){"a"}
# ary_1 = Array.new(3,"a")
# ary[0].next!
# ary_1[0].next!
# p ary
# p ary_1

# class A
  # $a = self
  # def hoge
    # $b = self
  # end
# end
# a = A.new
# p A == $a
# p $b
# a.hoge
# p $b
# p a.hoge
# p $b == a.hoge

# $o =self
# class MyClass
  # $a = self
  # def b
    # $b = self 
  # end
# end
# $c = MyClass.new
# p $a # MyClass
# p $o # main
# p $b # nil メソッドが発動しない限り、nil
# p $c # MyClassのインスタンス
# p $c.b # $bにself($cのこと)が入るので、$cのインスタンスと等しくなる
# 
# p $a == $o #=> false
# p $b == $c #=> true
# 
# $o =self
# class MyClass
#   $a = self
#   def b
#     $b = self
#   end
# end
# $c = MyClass.new
# p b = MyClass.new.b
# $c.b
# p $b
# p $b == $c

# class A
#   @@a = 1
#   @b = 2
#   p @@a #=> 1
#   p @b #=> 2
#   class << self
#     @@a = 10
#     @b = 20
#     p @@a #=> 10
#     p @b #=> 20
#   end
# end
# p A.class_variable_get(:@@a) #=> 10 クラス変数 共有されるので、再代入となる
# p A.instance_variable_get(:@b) #=> 2 インスタンス変数は共有されない
# p singleton_variable = class << A
#                           @b #=> 特異クラスで定義したインスタンス変数を表示する方法
#                       end

# module M1
# end
# module M2
# end
# class C1
#   include M1
#   include M2
# end
# class C2 < C1
#   def foo
#     p self.class.ancestors # => クラスインスタンスしかancestorsは処理されない
#   end
# end
# c = C2.new
# c.foo

# def sample_a
#   if block_given?
#     puts 'Yes:a'
#   else
#     puts 'No:a'
#   end
#   sample_b
# end

# def sample_b
#   if block_given?
#     puts 'Yes:b'
#     yield
#   else
#     puts 'No:b'
#   end
# end

# sample_a { puts 'I am a block' }
# # Yes:a ブロックはsample_aで渡されるが、
# # No:b method_bには渡されない

# def sample_a(...)
#   if block_given?
#     puts 'Yes:a'
#   else
#     puts 'No:a'
#   end
#   sample_b(...)
# end

# def sample_b($block)
#   if block_given?
#     puts 'Yes:b'
#     block.call
#   else
#     puts 'No:b'
#   end
# end

# sample_a { puts 'I am a block' }
# # Yes:a
# # Yes:b
# # I am a block

# class C
  # %W(homu mami mado).each {|name|
  # define_method(name) {"name is #{name}"}
  # }
# end
# c = C.new
# p %W(homu mami mado).map{|name| p c.send(name)}

# module M
  # def self.append_features(include_class_name)
    # p C.ancestors #=> [C, Object, Kernel, BasicObject]
    # puts "append_features"
    # super # このsuperを書かないとエラー発生
  # end
  # def func
    # p "Hello World"
  # end
# end
# 
# class C
  # include M
# end
# p C.ancestors #=> [C, M, Object, Kernel, BasicObject]

# class C
#   def func; puts "Hello"; end
# end

# class Child < C
#   undef_method :func
# end

# class GrandChild < Child
# end

# C.new.func # => Hello
# # Child.new.func # => NoMethodError
# # GrandChild.new.func # => NoMethodError

# def count
  # @count ||= 0
  # puts "#{@count}"
  # @count += 1
# end
# 
# count
# count
# count
# count 

# case文（どの条件にも一致しなければ何も起きずnilが返る）
# case 'chicken'
# when 'tomato', 'potato', 'carrot'
  # '野菜です'
# when 'orange', 'melon', 'banana'
  # '果物です'
# end
# => nil
# 
# パターンマッチ（どの条件にも一致しなければ例外が発生する）
# case 'chicken'
# in 'tomato' | 'potato' | 'carrot'
  # '野菜です'
# in 'orange' | 'melon' | 'banana'
  # '果物です'
# end
#=> NoMatchingPatternError (chicken)

# h = {a: "gold", b: "silver"}
# h.map {puts "key:#{_1}, value: #{_2}"} 
# h1 = [1,2,3,4]
# h1.map {puts "key:#{_1}, value: #{_2}"} 

# require "singleton"
# 
# class Foo
  # include Singleton
# end
# 
# p x = Foo.instance
# p y = Foo.instance

# require "date"

# date = Date.new(2000, 2, 24)
# datetime = DateTime.new(2000, 2, 24)

# puts(date << 12) #=> 1999-02-24
# puts(date >> 12) #=> 2001-02-24
# puts(datetime << 12) #=> 1999-02-24T00:00:00+00:00
# puts(datetime >> 12) #=> 2001-02-24T00:00:00+00:00


# h = {a: 1, b: 2, c: 3}
# case h
# in {a: a, b: b}  # こちらが優先されて出力されるので注意
  # p "a: #{a}, b: #{b}"
# in {a: a, b: b, c: c}
  # p "a: #{a}, b: #{b}, c: #{c}"
# end

# h = [1, 2, 3]
# case h
# in [x, y]
  # p [:two, x, y]
# in  [x, y, z]
  # p [:three, x, y, z]
# end

# module M
#    extend self #=> 自身のメソッドを特異メソッドとする
#   def greet
#     puts "Hello World!"
#   end
# end

# class SomeClass
#   extend M
# end

# M.greet
# SomeClass.greet

# p Class.superclass # Module
# p Module.superclass # Object
# p Object.superclass # BasicObject
# p BasicObject.superclass # nil

# class Speaker
  # @message = "Hello!"
# 
  # class << self
    # @message = "Howdy!"
# 
    # def speak
      # @message
    # end
  # end
# end
# 
# puts Speaker.speak # Hello!
# puts Speaker.singleton_class.speak # 特異クラスでのnometohderror
# puts Speaker.instance_variable_get(:@message) # Hello!
# puts Speaker.singleton_class.instance_variable_get(:@message) # Howdy

# class A
#   @@a = 1
#   @b = 2
#   # p @@a #=> 1
#   # p @b #=> 2
#   class << self
#     @@a = 10
#     @b = 20
#     # p @@a #=> 10
#     # p @b #=> 20
#   end
# end
# puts A.singleton_class.instance_variable_get(:@b) # 20
# puts A.singleton_class.class_variable_get(:@@a) # 10
# puts A.instance_variable_get(:@b) # 2
# puts A.class_variable_get(:@@a) # 10 こちらは再代入されているから 1は出力されない

# p [[1, "Foo"], [2, "bar"], [3, "baz"]].map { _2.upcase } # ["FOO", "BAR", "BAZ"]
# p [[1, "Foo"], [2, "bar"], [3, "baz"]].map { _2 } # ["Foo", "bar", "baz"]
# p [[1, "Foo"], [2, "bar"], [3, "baz"]].map { _1 } # [[1, "Foo"], [2, "bar"], [3, "baz"]]
# p [[1, "Foo"], [2, "bar"], [3, "baz"]].map { |n, v| n * 10 } # [10, 20, 30]
# p [[1, "Foo"], [2, "bar"], [3, "baz"]].map { _1 * 2 } # [10, 20, 30]

# a = [1,2,3,4,5,6]
# p a[3..5]
# p a[3,3]
# p a[3..-1]
# p a[-3..-1]
# p a[3..]
# p a[..2]

# obj = Object.new
# 
# def obj.hello
  # puts "Hi!"
# end
# p obj.object_id
# copy = obj.clone
# p copy.object_id
# copy.hello

# class C
#   @val = 3
#   attr_accessor :val
#   class << self
#     @val = 10
#   end
#   def initialize
#     @val = 1
#     @val *= 2 if @val
#   end
# end

# c = C.new
# c.val += 10

# p c.val #=> 12
# p C.instance_variable_get(:@val) #=> 3
# p C.singleton_class.instance_variable_get(:@val) #=> 10

# class Human
  # attr_reader :name
# 
  # alias_method :original_name, :name
# 
  # def name
    # "Mr. " + original_name
  # end
# 
  # def initialize(name)
    # @name = name
  # end
# end
# 
# human = Human.new("Andrew")
# puts human.name

# class Foo; end
# class Bar; end
# class Baz < Foo
# end
# 
# class Baz < Bar # superclass mismatch
# end

# class Foo; end
# class Baz < Foo
#   # include Moo

#   def method_a
#     puts "method_a in Baz"
#   end
# end

# module Moo
#   refine Baz do
#     def method_a
#       puts "method_a in Moo"
#     end
#   end
# end
# Baz.new.method_a

# using Moo

# Baz.new.method_a
# 
# class Foo
#   private
#   def private_method1
#     puts "private_method1"
#   end

#   def private_method2
#     puts "private_method2"
#   end

#   protected
#   def protected_method1
#     puts "protected_method1"
#   end

#   def protected_method2
#     puts "protected_method2"
#   end
# end

# class Baz < Foo
#   public :private_method2, :protected_method2
#   def public_method_from_private
#     private_method1
#   end

#   def public_method_from_protected
#     protected_method1
#   end
# end

# Baz.new.public_method_from_private
# Baz.new.private_method2
# Baz.new.public_method_from_protected
# Baz.new.protected_method2

# A = 10
# module M 
#   A = 1
#   class B
#     A = 2
#   end
#   class C
#     def const
#       A
#     end

#     def const_b
#       B::A
#     end
    
#     def const_top
#       ::A
#     end
#   end
# end

# p M::A
# p M::B::A
# p M::C.new.const
# p M::C.new.const_b
# p M::C.new.const_top

# class Foo
#   A = 1
# end

# module Bar
#   B = 2 
# end

# class Baz < Foo
#   include Bar
#   A = 10
#   B = 20
#   def const
#     p A
#     p B
#   end
# end
# Baz.new.const

# class Foo; end
# module M;end
# class Fooext < Foo
  # include M
# end
# p Foo.object_id
# p Fooext.object_id
# p M.object_id

# a = "hoge"
# b = a.dup
# p a.object_id
# p b.object_id
# puts "------------------------------"
# c = "foo"
# d = c.clone
# p c.object_id
# p d.object_id

# ary = [1,2,3].map{|n| n.freeze}.freeze
# p ary_dup = ary.dup.frozen? # false
# p ary_clone = ary.clone.frozen? # true

# obj = "string"
# def obj.hoge
#   puts "hello world"
# end
# obj.freeze
# obj_dup = obj.dup
# p obj_dup.frozen? # false
# # p obj_dup.hoge ## nomethoderror 

# obj_clone = obj.clone 
# p obj_clone.frozen? # true
# p obj_clone.hoge # hello world

# class C
  # protected
    # def initialize
    # end
  # end
  # 
  # p C.new.methods.include? :initialize

# /(http:\/\/www(\.)(.*)\/)/ =~ "http://www.abc.com/"
# p $0 # ファイル名
# p $1 # １つ目のグループ http://www.abc.com/
# p $2 # .
# p $3 # abc.com

# class Stack
#   def initialize
#     @contents = []
#   end

#   [:push, :pop].each do |name|
#     instance_eval(<<-EOF)
#       def #{name}(*args)
#         @contents.send(:#{name}, *args)
#       end
#     EOF
#   end
# end
# p Stack.instance_methods #  class_evalを使用すると、インスタンスメソッドに追加されるので、こちらに表示される
# p Stack.methods # instance_evalをクラス内で使用すると、特異メソッド定義となるので、こちらに追加される

# def bar(n, a)
#   puts a + n
# end

# def foo(n, ...)
#   bar(n, ...)
# end

# foo(1,2)

# letters = catch(:done) do
#   ("a".."z").each do |a|
#     ("a".."z").each do |b|
#       ("a".."z").each do |c|
#         if a < b && b < c
#           throw(:done, [a,b,c])
#         end
#       end
#     end
#   end
# end

# puts letters.join

# h = {a: 1, b: 2, c: 3}
# case h
# in {}
#   p [:two, a, b]
# in  {a: a, b: b, c: c}
#   p [:three, a,b,c]
# end

# def m
  # begin
    # 1
  # rescue
    # 2
  # else
    # 3
  # ensure
    # 4
  # end
# end
# p m

# class User
  # def hello
    # puts "hello I'm #{self.name}"
  # end
# 
  # private
  # def name
    # "alice"
  # end
# end
# 
# user = User.new
# user.hello 

# module M; end
# class X
  # prepend M
  # p self.ancestors
# end

# ary = [["a", "gold"], ["b", "silver"]]
# puts ary.map{ "#{_1}: #{_2}"}
# # a: gold
# # b: silver

# hash = {a: "gold", b: "silver"}
# puts hash.map{ "#{_1}: #{_2}"}
# # a: gold
# # b: silver

# a, b = catch :exit do
#   for x in 1..10
#     for y in 1..10
#       throw :exit, [x, y] if x + y == 10
#     end
#   end
# end
# puts a, b

# a, b = catch :exit do
#   for x in 1..10
#     for y in 1..10
#       return [x, y] if x + y == 10
#     end
#   end
# end
# puts a, b

# a, b = catch :exit do
#   for x in 1..10
#     for y in 1..10
#       break [x, y] if x + y == 10
#     end
#   end
# end
# puts a, b

# a, b = catch :exit do
#   for x in 1..10
#     for y in 1..10
#       next [x, y] if x + y == 10
#     end
#   end
# end
# puts a,b

# class Foo
  # def self.const_missing(name)
    # "定数 #{name} はありません"
  # end
# end
# 
# p Foo::C

# def foo(n)
  # n ** n
# end
# 
# foo = Proc.new { |n|
  # n * 3
# }
# 
# puts foo 2 * 2

# mod = Module.new
# 
# mod.module_eval do
  # EVAL_CONST = 100
# end
# 
# puts Object.const_defined? :EVAL_CONST # trueと表示される
# puts mod.const_defined? :EVAL_CONST # trueと表示される

#p "Bibbidi-Bobbidi-Boo".match(/B.bbidi-?+/)
# p /B.bbidi-B.bbidi-/.match("Bibbidi-Bobbidi-Boo")
# p /(B.bbidi-)+/.match("Bibbidi-Bobbidi-Boo")


# def lambda_test
  # lambda = -> {return "呼び出し元へ復帰"}
  # lambda.call
  # 2
# end 
# p lambda_test

# def proc_test
  # proc = Proc.new{return "脱出します"}
  # proc.call
  # 2
# end
# p proc_test

# x = "".freeze
# y = ["".freeze,].freeze
# p x.frozen?
# p x = "foo"
# p x += "123"
# p y.frozen?
# p y[1] << "123"

# module P
  # def name
    # puts "prepend P"
    # super
  # end
# end
# 
# class C
  # def name
    # puts "class C"
  # end
  # prepend P
# end
# 
# c = C.new
#  c.name 

# class A
#   def self.foo
#     self.bar
#   end

#   def fiz
#     bar
#   end

#   private
#   def bar
#     "instance"
#   end

#   def self.bar
#     "class1"
#   end
# end
# puts A.foo # => "instance"
# puts A.new.fiz "class1"

# class A
  # puts "a"
  # @@x = 0
  # class << self
    # puts "b"
    # @@x = 1
    # def x 
      # puts "c "
      # @@x
    # end
  # end
  # def x
    # puts "d"
    # @@x = 2
  # end
# end
# 
# class B < A
  # puts "e"
  # @@x = 3
# end
# p A.x   #=> a b e c 3

# ary = [1,2,3].freeze
# ary_1 = [4,5,6].freeze
# ary += [4,5]
# ary_1 << [7,8] #=> FrozenError
# p ary
# 

# def foo(arg1:100, arg2:200)
  # puts arg1
  # puts arg2
# end
# 
# option = {arg2: 900}
# 
# foo arg1:500, arg2:1000

# val = 100

# def method(val)
#   yield(15 + val)
# end

# _proc = Proc.new{|arg| 
#   puts val # 100 
#   puts arg # 115 
# }

# p method(val, &_proc)

# p (1..100).each.lazy.chunk(&:even?).take(5).force

# m = Module.new

# CONST = "Constant in Toplevel"

# _proc = Proc.new do
#   CONST = "Constant in Proc"
# end

# m.instance_eval(<<-EOS)
#   CONST = "Constant in Module instance"

#   def const
#     CONST
#   end
# EOS

# p m.module_eval(&_proc) # Constant in Proc

# p m.const

# open('textfile.txt', 'r+') do |f|
#   data = f.read.upcase
#   f.rewind
#   f.puts data
# end

# module K
#   class P
#     CONST = "Good, night"
#   end
# end

# module K::P::M
#   class C
#     CONST = "Good, evening"
#   end
# end

# module M
#   class C
#     CONST = "Hello, world"
#   end
# end

# class K::P
  # class M::C
  #   p CONST
  # end
# end

# module M
#   CONST = "Hello, world"
# end

# module M
#   def self.say
#     CONST
#   end
# end

# p M::say

# module M
#   CONST = "Hello, world"
# end

# M.class_eval(<<-CODE)
#   def self.say
#     CONST
#   end
# CODE

# p M::say

# CONST_LIST_A = ['001', '002', '003']
# p CONST_LIST_A.object_id
# p CONST_LIST_A.map{|id| id << 'hoge'}.object_id

# v1 = 1 / 2 == 0
# v2 = !!v1 or raise RuntimeError # || だとエラー
# puts v2 and false # && とすると false

# def round(n, **option)
#   n.round(**option)
#   # p option #=>{:half=>:even}
#   # p **option #=>{:half=>:even}
# end
# params = {half: :even}
# p round(2, **params)

# class C
  # def f; puts "World"; end
# end
# 
# class Child < C
  # def f; puts "Hello"; end
# end
# 
# child = Child.new
# puts child.
# 
# Child.class_eval { remove_method :f }
# 
# puts child.f

# def bar(*ary, key: "default", **params)
#   p key
#   p ary
#   p params
# end

# def foo(...)
#   bar(...)
# end

# foo(*[1,2,3], key: "value", broodtype: "o")

# p /(B.bbidi-)+/.scan("Bibbidi-Bobbidi-Boo") #=> #<MatchData "Bibbidi-Bobbidi-" 1:"Bobbidi-">
# p "Bibbidi-Bobbidi-Boo".scan(/B.bbidi-/) #=> ["Bibbidi-", "Bobbidi-"]

# p Object.constants
# p Object.const_defined?(:ENV)
# p Object.const_get(:RUBY_VERSION)

# def foo(arg1=100, *args)
#   puts arg1
#   puts *args
# end

# args = [200, 900]

# foo(*args)
# class A; end
# m = A.new

# CONST = "Constant in Toplevel"

# _proc = Proc.new do
#   CONST = "Constant in Proc"
# end

# m.instance_eval(<<-EOS)
#   # CONST = "Constant in Module instance"

#   def const
#     CONST
#   end
# EOS

# A.instance_eval(&_proc)

# p m.const

# 複数の引数の場合は、順番に注意！！！
# def method(a, b = 1, *c, d, e:, f: 2, **g, &h)
#   return a, b, c, d, e, f, g, h
#   end
# p method(0, 1, 2, 3, e:4, f:5, g:6) { 7 }

# module Extensions1
#   refine String do
#     def hello
#       puts self + "hello Extensions1"
#     end
#     def hi
#       puts self + "hi Extension1"
#     end
#   end
# end

# module Extensions2
#   refine String do
#     def hello 
#       puts self + "hello Extensions2"
#     end
#   end
# end

# class RefineTest
#   us@ing Extensions1
#   "outer1".hello # => outer1 hello Extensions1
  
#   class InnerClass
#     using Extensions2
#     # innerClass内のみで変更が適用される
#     "inner".hello # => inner hello Extensions2
#     "outer2".hi # => outer2 hi Extensions1
#   end
  
#   "outer2".hello # => outer2 hello Extensions1
#   "outer2".hi # => outer2 hi Extensions1
# end
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
