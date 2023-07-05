# # begin内がメソッドの処理が入っていて冗長
# def fizz_buzz(n)
#   begin
#     if n % 15 == 0
#       'fizzbuzz'
#     elsif n % 5 == 0
#       'fizz'
#     elsif n % 3 == 0
#       'buzz'
#     else
#       n.to_s
#     end
#   rescue => e
#     puts "#{e.class} #{e.message}"
#   end
# end

# begin/endを省略して見やすくする
def fizz_buzz(n)
    if n % 15 == 0
      'fizzbuzz'
    elsif n % 5 == 0
      'fizz'
    elsif n % 3 == 0
      'buzz'
    else
      n.to_s
    end
  rescue => e
    puts "#{e.class} #{e.message}"
  end
end