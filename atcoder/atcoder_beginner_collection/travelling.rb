current_time, current_x, current_y = 0, 0, 0
 
gets.to_i.times do
   time, x, y = gets.split.map(&:to_i)
   remaining_time = time - current_time
   moving_distance = (x - current_x).abs + (y - current_y).abs
   if remaining_time < moving_distance || (remaining_time - moving_distance).odd?
       puts 'No'
       exit
   end
   
    current_time += remaining_time
    current_x = x
    current_y = y
end
 
puts 'Yes'