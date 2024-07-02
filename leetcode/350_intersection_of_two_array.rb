# @param {Integer[]} nums1
# @param {Integer[]} nums2
# @return {Integer[]}
nums1 = [1, 2]
nums2 = [1, 1]

def intersect(nums1, nums2)
  result = []

  nums1.each do |num|
    if nums2.include?(num)
      result << num
      nums2.delete_at(nums2.index(num))
    end
  end
  result
end

intersect(nums1, nums2)
