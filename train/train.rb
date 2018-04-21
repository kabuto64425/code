@fact_memo = {}

def fact(n)
	if @fact_memo.has_key?([n])
		return @fact_memo[[n]]
	end
	
	if n == 0
		return 1
	elsif n == 1
		return 1
	else
		result = n * fact(n-1)
		@fact_memo[[n]] = result
		return result
	end
end

def permutation(n,r)
	fact(n)/fact(n-r)
end

str = STDIN.gets

nums = str.split(",")

exit if nums.length < 3

isValid = nums.all? do |num|
  num =~ /^[0-9]+$/
end

exit if !isValid

length = nums[0].to_i
start = nums[1].to_i
goal = nums[2].to_i

#1番目の駅が最も上としたときの、目的駅より下の駅数と上の駅数
#引き返す駅の候補数として用いる
down = length - goal
up = length - down - 1

#目的駅を通り過ぎた場合に目的駅より下の駅で引き返しているかどうかのフラグ
turnAtDownFlag = (start < goal)

#出発駅では引き返すことが出来ない。なので、出発駅のある側の候補数を1つ減らす
if !turnAtDownFlag
	down -= 1
else
	up -= 1
end

#それぞれ、引き返すのに用いた駅の数
turnAtDown = 0
turnAtUp = 0

result = 0
#引き返した駅の数ごとでループを回す。
#出発駅の反対側から引き返す駅の選び方を求める。
#どちらかの駅をすべて選びきるまで続ける
while turnAtDown <= down and turnAtUp <= up
	#下の駅の引き返す順番*上の駅の引き返す順番でそれぞれ引き返す回数の通り数を求めることが出来る
	result += permutation(down,turnAtDown) * permutation(up,turnAtUp)
	if turnAtDownFlag
		turnAtDown += 1
		turnAtDownFlag = !turnAtDownFlag
	else
		turnAtUp += 1
		turnAtDownFlag = !turnAtDownFlag
	end
end
puts result