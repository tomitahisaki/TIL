# class NonasciiError < StandardError
# end

# File.open("sliver_practice.txt") do |io|
#   io.each_line do |str|
#     begin
#       raise(NonasciiError, "non ascii character detected") unless str.ascii_only?
#     rescue => ex
#       puts "#{ex.message} : #{str}"
#     end
#   end
# end




# x = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
# x.chunk {|n| n.even?}.each {|even, ary| p [even, ary] }
# => [false, [3, 1]]
#    [true, [4]]
#    [false, [1, 5, 9]]
#    [true, [2, 6]]
#    [false, [5, 3, 5]]




# p "abcdefg".match(/[a-c]*/)




# class Team
#   attr_reader :members

#   def initialize(members = [])
#     @members = members
#   end

#   # メンバーの追加
#   def +(member)
#     @members << member
#   end

#   # メンバーの削除
#   def -(member)
#     @members.delete(member)
#   end

#   # チームの追加
#   def <<(other)
#     fail 'error' unless other.respond_to?(:members)
#     @members += other.members
#   end
# end

# team_a = Team.new(%w(tanaka sato suzuki))
# print team_a.members, "\n"
# team_a + 'obokata'
# print team_a.members, "\n"
# team_a - 'obokata'
# print team_a.members, "\n"

# team_b = Team.new(%w(matz larry guido))
# team_a << team_b
# print team_a.members, "\n"

# begin
#   team_a << "not Team class"
#   print team_a.members, "\n"
# rescue => e
#   puts e.message
# end

# ["tanaka", "sato", "suzuki"]
# ["tanaka", "sato", "suzuki", "obokata"]
# ["tanaka", "sato", "suzuki"]
# ["tanaka", "sato", "suzuki", "matz", "larry", "guido"]
# error

p "a b c d".split()
p "a\nb\nc\nd".split(//)
p "a\tb\tc\td".split()
p "a b c d".split(//)

# ["a", "b", "c", "d"]
# ["a", "\n", "b", "\n", "c", "\n", "d"]
# ["a", "b", "c", "d"]
# ["a", " ", "b", " ", "c", " ", "d"]
