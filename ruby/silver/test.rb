a = {"Foo" => "hoge", "Bar" => "piyo", "Baz" => "fuga"}

p a.sort{|a, b| a[0] <=> b[0]}