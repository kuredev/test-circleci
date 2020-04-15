puts "hoge"
puts 'hoge'


puts "hoge"
puts 'hoge'


def raises_sometimes(value)
  if value == 1
    raise '1 is bad value!'
  elif value == 2
    raise '2 is bad value, too!'
  end
end
