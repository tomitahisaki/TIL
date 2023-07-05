retry_count = 0
puts "処理を開始する"

begin
  1 / 0
rescue
  retry_count += 1
  if retry_count <= 3
    puts "retryします #{retry_count}"
    retry
  else
    puts "retryに失敗"
  end
end