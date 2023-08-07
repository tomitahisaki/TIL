class C
  protected
    def initialize
    end
  end
  
  p C.new.methods.include? :initialize