# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {TreeNode} root
# @return {Boolean}
def evaluate_tree(root)
  return false if root.nil?
  return root.val if root.left.nil? && root.right.nil?

  l_tree = evaluate_tree(root.left)
  r_tree = evaluate_tree(root.right)

  if root.val == 2
    return l_tree || r_tree
  else
    return l_tree && r_tree
  end

end

p evaluate_tree([2,1,3,null,null,0,1])
