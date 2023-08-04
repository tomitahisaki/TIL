module M
  def self.class_m
    "M.class_m"
  end
end

class C
  include M
end

p C.methods.include? :class_m