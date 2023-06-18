text = <<-TEXT
{
  japan:	'yen',
  america:'dollar',
  italy:     'euro'
}
TEXT
puts text.gsub(/:[ \t]*/,": ")

# {
# japan: 'yen',
# america: 'dollar',
# italy: 'euro'
# }