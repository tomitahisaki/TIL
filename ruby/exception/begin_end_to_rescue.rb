require 'date'

def to_date(string)
  begin
    Date.parse(string)
  rescue ArgumentError
    "パースできない"
  end
end

# p to_date('2023-7-2')
# p to_date('abcdef')

# begin/endをrescueの省略↓
# Standardとサブクラスのみと捕捉なので推奨しない
# def to_date(string)
# 	Date.parse(string) rescue 'パースできない'
# end