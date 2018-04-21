#線分同士が交差しているかを判定
def isCross(line1, line2)
	sortedLine1 = line1.sort
	sortedLine2 = line2.sort
	
	s1 = (sortedLine1[0] - sortedLine2[0]) * (sortedLine1[1] - sortedLine2[1])
	s2 = (sortedLine1[0] - sortedLine2[1]) * (sortedLine1[1] - sortedLine2[0])
	
	return true if s1 > 0 and s2 < 0
	return false
end

str = STDIN.gets

exit if str !~ /^[0-9]+$/

num  = str.to_i

count = 0
#円順列のため、numから1引いて計算を行う。
(1..(num - 1)).to_a.permutation().to_a.each do |a|
	root = [0].concat(a)
	proposedLines = []
	(root.size).times do |i|
		next if (root[i] + 1) % root.size == root[(i + 1) % root.size]
		next if (root[i] - 1) % root.size == root[(i + 1) % root.size]
		
		proposedLines << [root[i], root[(i + 1) % root.size]]
	end
	proposedLines.combination(2).each do |lines|
		count += 1 if isCross(lines[0], lines[1])
	end
end

puts count