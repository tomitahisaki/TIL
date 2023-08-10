# p ("aaaaaa".."zzzzzz").lazy.select { |e| e.end_with?("f")}.first(3)
# p ("aaaaaa".."zzzzzz").lazy.select { |e| e.end_with?("f")}.take(3)
# p ("aaaaaa".."zzzzzz").lazy.select { |e| e.end_with?("f")}.take(3).force
# p ("aaaaaa".."zzzzzz").lazy.select { |e| e.end_with?("f")}.first(3).force

# add = Proc.new do |x , y|
  # x + y
# end
# p add(1, 2)

# def fx(*args)
  # p(args)
# end
# fx(["apple", "banana", "carrot"])

# AnError = Class.new(Exception)
# begin
#   raise AnError
# rescue
#   puts "Bare rescue"
# rescue StandardError
#   puts "StandardError rescue"
# rescue AnError
#   puts "AnError rescue"
# rescue Exception
#   puts "Exception rescue"
# end

# class Identity
#   def self.this_object
#     self
#   end
  
#   def this_object
#     self
#   end
# end

# p a = Identity.this_object
# p b = Identity.this_object

# p c = Identity.new.this_object
# p d = Identity.new.this_object
# 
# p a == b
# p c == d

# while not DATA.eof?
#   print DATA.read 1
# end

# __END__
# 1
# 2
# 3
# 4

# ary = ["foo", "bar", nil, "baz"]

# p ary.map{ |i| i&.upcase}

# class ShoppingList
#   def initialize
#     @items = []
#   end

#   def add_item(item)
#     @items << item
#   end

#   def to_s
#     @items.map { |e| "- #{e}" }.join("\n")
#   end

#   # def __(1)__
#   #   "ShoppingList:\n  @items: #{@items.inspect}"
#   # end
# end

# list = ShoppingList.new

# list.add_item("Milk")
# list.add_item("Bread")
# list.add_item("Eggs")

# p list
# puts list


# m = Module.new
# CONST = "Constant in Toplevel"

# _proc = Proc.new do
#   CONST = "Constant in Proc"
# end

# m.module_eval(<<-EOS)
# CONST = "Constant in Module instance"

# def const
#   CONST
# end
# EOS

# m.module_eval(&_proc)

# p m.const

# module M
#   CONST = "Hello, world"
# end

# class M::C
#   CONST = "kotti"
#   def awesome_method
#     CONST
#   end
# end

# p M::C.new.awesome_method

# %r|(http://www(\.)(.*)/)| =~ "http://www.abc.com/"

# p $0
# p $1
# p $2
# p $3


class A
  def foo
    self.bar
  end

  private

  def bar
    "baz"
  end

  def self.bar
    "quux"
  end
end

puts A.bar