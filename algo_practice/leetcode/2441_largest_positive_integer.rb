# @param {Integer[]} nums
# @return {Integer}
def find_max_k(nums) # [-9,-43,24,-23,-16,-30,-38,-30]
  nums_abs = nums.uniq.map(&:abs)
  max_nums = nums_abs.tally.sort.reverse.select { |k, v| v > 1 }
  if max_nums.length > 0
    max_nums[0].flatten[0]
  else 
    -1
  end
end


p find_max_k([-30,34,1,32,26,-9,-30,22,-49,29,48,47,38,4,43,12,-1,-8,11,-37,32,40,9,15,-34,-34,-16,-5,26,-44,-36,-13,-16,10,39,-17,-22,17,-16]) # -34
