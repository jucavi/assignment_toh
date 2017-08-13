max = 6
1.upto(max) do |i|
  line = ""
      i.downto(1) {|j| line += ("* " + " "*6 + "* ")}
  puts line.rjust(max + i)
end

