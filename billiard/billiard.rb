def countBilliard(m, n, startPosition)
	vec = [1, 1]
	position = Marshal.load(Marshal.dump(startPosition))
	
	count = 0
	
	isRequiredDistinctionalVec = true
	#角の場合のみ打つ方向が1つしかないため。
	isRequiredDistinctionalVec = false if startPosition == [0, 0]
	
	while true
		position[0] += vec[0]
		position[1] += vec[1]
		
		count += 1
		
		#反射判定
		vec[0] *= -1 if position[0] == 0 or position[0] == n
		vec[1] *= -1 if position[1] == 0 or position[1] == m
		
		#終了判定
		#1周するか、隅に来ると、これ以上調べる必要がなくなる
		break if position[0] == 0 and position[1] == 0
		break if position[0] == 0 and position[1] == m
		break if position[0] == n and position[1] == 0
		break if position[0] == n and position[1] == m
		
		#1周の場合は、別方向から打っても逆走するだけのため、考慮する必要が無い
		isRequiredDistinctionalVec = false if position == startPosition
		break if position == startPosition
	end
	
	if isRequiredDistinctionalVec
		position = Marshal.load(Marshal.dump(startPosition))
		vec = [-1, 1]
		while true
			position[0] += vec[0]
			position[1] += vec[1]
			
			count += 1
			
			vec[0] *= -1 if position[0] == 0 or position[0] == n
			vec[1] *= -1 if position[1] == 0 or position[1] == m
			
			break if position[0] == 0 and position[1] == 0
			break if position[0] == 0 and position[1] == m
			break if position[0] == n and position[1] == 0
			break if position[0] == n and position[1] == m
		end
	end
	
	return count
end

str = STDIN.gets

nums = str.split(",")

exit if nums.length < 2

isValid = nums.all? do |num|
  num =~ /^[0-9]+$/
end

exit if !isValid

m = nums[0].to_i
n = nums[1].to_i

results = []

#対称性より、下半分は考慮しなくてよい。
(0..(n / 2).floor).each do |y|
	startPosition = [y, 0]
	results << countBilliard(m, n ,startPosition)
end

puts results.min
puts results.max