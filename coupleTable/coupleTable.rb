def fact(n)
	if n == 0
		return 1
	elsif n == 1
		return 1
	else
		n * fact(n-1)
	end
end

#男性が先に円順列で1パターン並んだ時に、間に女性が入る場合の数を求めます。
def countOneManRow(log, couple, i)
	if log.size == couple
		return 1;
	end
	president = (1..couple).to_a - [(i - 1) % couple + 1] - [i % couple + 1] - log
	
	count = 0
	
	president.each do |woman|
		count += countOneManRow(log + [woman], couple, i + 1)
	end
	
	return count
end

str = STDIN.gets

exit if str !~ /^[0-9]+$/

couple = str.to_i

#男性が、先に円順列で1パターン並んだ時に、間に女性が入る場合の数を求め、
#その場合の数が、さらに男性が先に円順列で並んだパターン数だけあるので、
#以下のような式で答えが出ます。
puts countOneManRow([], couple, 1) * fact(couple - 1)