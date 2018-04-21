def fact(n)
	if n == 0
		return 1
	elsif n == 1
		return 1
	else
		n * fact(n-1)
	end
end

def combination(n,r)
	fact(n)/(fact(r)*fact(n-r))
end

def countSeminar(sessions, segments)
	i = 0
	count = 0

	return 0 if sessions == 0 and segments == 0

	#各会場で何コマずつセッションを受けるか
	while sessions * i <= segments
		#どのセッションを受けるかの組み合わせを最初に計算
		temp = combination(segments, sessions * i)
		
		j = 0
		
		#受けたセッションの中から、どの会場を受けるか、その組み合わせを計算
		while j < sessions
			temp *=  combination(sessions - i * j, i)
			j += 1
		end
		
		count += temp
		i += 1
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

sessions = nums[0].to_i
segments = nums[1].to_i

puts countSeminar(sessions, segments)