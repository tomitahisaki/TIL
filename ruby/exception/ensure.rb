# 正常に終了した場合
ret = begin
        'OK'
      rescue
        'error'
      ensure
        'ensure'
      end
# ret => OK

# 例外が発生した場合
ret = begin
        1/0
      rescue
        'error'
      ensure
        'ensure'
      end
# ret => error