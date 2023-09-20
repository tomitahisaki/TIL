## フラットスコープを使って、トップレベルで使用可能に
## スコープゲートも用いられるので、外部のメソッドから参照できない
# def define_methods
  # shared = 0
# 
  # Kernel.send :define_method, :counter do
    # shared
  # end
# 
  # Kernel.send :define_method, :inc do |x|
    # shared += x
  # end
# end
# 
# define_methods
# 
# p counter
# inc(4)
# p counter


## 特異クラスはどうなっているのかを調査してみる そしてどんな継承を辿っているのか
class C; end
c = C.new
p c.singleton_class #=> #<Class:#<C:0x0000000104da9cb0>>
p c.class #=> C
# p c.superclass  #=> NoMethodError
p c.singleton_class.superclass #=> C

p C.singleton_class #=> #<Class:C>
p C.singleton_class.superclass #=> #<Class:Object>

p c.singleton_class.ancestors #=> [#<Class:#<C:0x0000000100e79c20>>, C, Object, Kernel, BasicObject]
p C.singleton_class.ancestors #=> [#<Class:C>, #<Class:Object>, #<Class:BasicObject>, Class, Module, Object, Kernel, BasicObject]
