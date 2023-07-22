hash1 = {1 => "foo", 2 => "hoge", 3 => "Baz"}
hash2 = {1 => "Foo", 2 => "hoge", 3 => "Baz"}

p hash1.update(hash2).sort{ | a, b | a[1] <=> b[1] }