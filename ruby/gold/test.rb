class Foo; end

# ネストが変化しない
Foo.class_eval do
  CONST_IN_BLOCK = 100
end

# ネストが変化する
Foo.class_eval(<<-EVAL)
  CONST_IN_HERE_DOC = 200
EVAL

puts "BLOCK: CONST is defined? #{Foo.const_defined?(:CONST_IN_BLOCK, false)}"
puts "BLOCK: CONST is defined? #{Object.const_defined?(:CONST_IN_BLOCK, false)}"

puts "HERE_DOC: CONST is defined? #{Foo.const_defined?(:CONST_IN_HERE_DOC, false)}"
puts "HERE_DOC: CONST is defined? #{Object.const_defined?(:CONST_IN_HERE_DOC, false)}"

p CONST_IN_BLOCK
p Foo::CONST_IN_HERE_DOC