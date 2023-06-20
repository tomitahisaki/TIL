text = <<-TEXT
You say yes. - @jnchito 8s
I say no. - @BarackObama 12m
You say stop. - @dhh 7h
I say go go go. - @ladygaga Feb 20
Hello, goodbye. - @BillGates 11 Apr 2015
TEXT

# # 日時をぬきだす
# p text.scan(/(\d+[smh]|(?:\d+ )?[A-Z][a-z]{2} \d+)/)
# # [["8s"], ["12m"], ["7h"], ["Feb 20"], ["11 Apr 2015"]]

# # ツイートをぬきだす
# p text.scan(/^(.*) -/)
# # [["You say yes."], ["I say no."], ["You say stop."], ["I say go go go."], ["Hello, goodbye."]]

# # アカウントを抜き出す
# p text.scan(/(@\w+)/)
# # [["@jnchito"], ["@BarackObama"], ["@dhh"], ["@ladygaga"], ["@BillGates"]]

# すべてを抜き出す
p text.scan(/^(.*) - (@\w+) (\d+[smh]|(?:\d+ )?[A-Z][a-z]{2} \d+)/)
# [["You say yes.", "@jnchito", "8s"], ["I say no.", "@BarackObama", "12m"], ["You say stop.", "@dhh", "7h"], ["I say go go go.", "@ladygaga", "Feb 20"], ["Hello, goodbye.", "@BillGates", "11 Apr 2015"]]