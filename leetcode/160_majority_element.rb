# @param {Integer[]} nums
# @return {Integer}
def majority_element(nums)
  nums.sort!
  return nums[nums.length/2]
end

p majority_element(nums)
