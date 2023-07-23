class Stack
  def initialize
    @contents = []
  end

  [:push, :pop].each do |name|
    define_method(name) do |*args|
      @contents.send(name, *args)
    end
  end
end

stack = Stack.new
stack.push("foo")
stack.push("bar")
p stack.pop