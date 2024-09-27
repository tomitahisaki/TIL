# 標準出力でa,b,cの値を受け取る
# 標準入力　< < <
ab, ac, bc = gets.chomp.split(' ')

if ab == '<'
  if ac == '<' # a < b  c
    if bc == '<' # a < b < c
      puts 'B'
    else # a < c < b
      puts 'C'
    end
  else # c < a < b
    puts 'A'
  end
else
  if ac == '<' # b < a < c
    puts 'A'
  else # b < c < a
    if bc == '<' # b < c < a
      puts 'C'
    else # c < b < a
      puts 'B'
    end      
  end
end
