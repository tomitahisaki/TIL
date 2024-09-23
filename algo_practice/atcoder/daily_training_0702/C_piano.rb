# 複数の標準入力が与えられる
# 3 2
# 3 2 5
# 4 1

n = 2
m = 3
a = [3, 2, 5]
b = [4, 1]

def check_piano(n, m, a, b)
  c = a + b
  c.sort!
  c.each_with_index do |v, i|
    if a.include?(c[i],c[i+1])
  end

end
