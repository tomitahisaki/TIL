class C1

end

module Mod
  
end

class C2 < C1
  include Mod
end

p C2.ancestors