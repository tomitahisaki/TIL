# @param {Integer[][]} grid
# @return {Integer[][]}
def largest_local(grid) # [[9,9,8,1],[5,6,2,6],[8,2,6,4],[6,2,2,2]]
  row = grid.length
  col = grid[0].length
  result = []
  (0..row-3).each do |i|
    col_result = []
    (0..col-3).each do |j|
      matrix = []
      (i..i+2).each do |m|
        (j..j+2).each do |n|
          matrix << grid[m][n]
        end
      end
      col_result << matrix.max
    end
    result << col_result
  end
  return result
end


# [
# [9,9,8,1]
# [5,6,2,6]
# [8,2,6,4]
# [6,2,2,2]
# ]

# grid 4の場合、3"行"3"列"のマトリックスが2つある
# grid 5の場合、3"行"3"列"のマトリックスが3つある
# grid 6の場合、3"行"3"列"のマトリックスが4つある
