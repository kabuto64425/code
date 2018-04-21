#0,1,2を使う3進数にすると2が含まれないかどうか
def checkNotContainTwo(n)
	while n != 0
		if n % 3 == 2
			return false
		end
		n = n / 3
	end
	return true
end

str = STDIN.gets

exit if str !~ /^[0-9]+$/

num  = str.to_i

count = 0

#0,1,2を使う3進数にしたとき、各桁が0,1だと-1,0,1で表現したときとすべての桁で同じになる
#そこで、各数字を0,1,2の3進数にしたとき、2が含まれていない数字をカウントして出力
(num + 1).times do |n|
	if checkNotContainTwo(n)
		count += 1
	end
end

puts count