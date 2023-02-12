# 動的計画法 部分和問題
 
# 配列初期化の為のメソッドを準備
def darray(n1,n2,ini=nil)
  Array.new(n1) { Array.new(n2) { ini } } 
end
 
N, S = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
 
# 動的計画法 配列の初期化
dp = darray(N+1, S+1, false)
# 何も選ばずに和が0になる選択肢しかないので、カード0枚目でjが0以外の場合はfalse
dp[0][0] = true
(1..S).each { |s| dp[0][s] = false }
 
(1..N).each do |i|
  (0..S).each do |j|
    # 目指す総和より取ろうとするカードの方が大きい場合はカードを取れない
    if j < A[i-1] 
      dp[i][j] = dp[i-1][j]
    elsif dp[i-1][j] || dp[i-1][j-A[i-1]]
      dp[i][j] = true
    else
      dp[i][j] = false
    end
  end
end
 
puts dp[N][S] ? 'Yes' : 'No'