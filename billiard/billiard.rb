def countBilliard(m, n, startPosition)
	vec = [1, 1]
	position = Marshal.load(Marshal.dump(startPosition))
	
	count = 0
	
	isRequiredDistinctionalVec = true
	#�p�̏ꍇ�̂ݑł�����1�����Ȃ����߁B
	isRequiredDistinctionalVec = false if startPosition == [0, 0]
	
	while true
		position[0] += vec[0]
		position[1] += vec[1]
		
		count += 1
		
		#���˔���
		vec[0] *= -1 if position[0] == 0 or position[0] == n
		vec[1] *= -1 if position[1] == 0 or position[1] == m
		
		#�I������
		#1�����邩�A���ɗ���ƁA����ȏ㒲�ׂ�K�v���Ȃ��Ȃ�
		break if position[0] == 0 and position[1] == 0
		break if position[0] == 0 and position[1] == m
		break if position[0] == n and position[1] == 0
		break if position[0] == n and position[1] == m
		
		#1���̏ꍇ�́A�ʕ�������ł��Ă��t�����邾���̂��߁A�l������K�v������
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

#�Ώ̐����A�������͍l�����Ȃ��Ă悢�B
(0..(n / 2).floor).each do |y|
	startPosition = [y, 0]
	results << countBilliard(m, n ,startPosition)
end

puts results.min
puts results.max