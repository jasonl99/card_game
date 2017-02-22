class Foo
end

h = {} of Foo=>String

h[Foo.new] = "Foo 1"
h[Foo.new] = "Foo 2"
h[Foo.new] = "Bar 1"
h[Foo.new] = "Bar 2"

h.each do |k,v|
  puts k
  puts v
end
