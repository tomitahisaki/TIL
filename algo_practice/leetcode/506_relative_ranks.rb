# @param {Integer[]} score
# @return {String[]}
def find_relative_ranks(score)
  sorted_score = score.sort.reverse
  finalized_score = score.map do |s|
    index = sorted_score.index(s)
    if index == 0
      "Gold Medal"
    elsif index == 1
      "Silver Medal"
    elsif index == 2
      "Bronze Medal"
    else
      (index + 1).to_s
    end
  end
  return finalized_score
end


p find_relative_ranks([5, 4, 3, 2, 1]) # ["Gold Medal", "Silver Medal", "Bronze Medal", "4", "5"]
p find_relative_ranks([10, 3, 8, 9, 4]) # ["Gold Medal", "5", "Bronze Medal", "Silver Medal", "4"]
