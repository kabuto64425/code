@memo = {}

def janken(coinsA, coinsB, round)
	if @memo.has_key?([coinsA, coinsB, round])
		return @memo[[coinsA, coinsB, round]]
	end
	return 1 if coinsA == 0 or coinsB == 0
	#残り回数が0で決着がついてないと終了
	return 0 if round == 0

	count = 0
	#-1:Bの勝ち 0:あいこ 1:Aの勝ち
	(-1..1).each do |judge|
		count += janken(coinsA + judge, coinsB - judge, round - 1)
	end
	
	#AとBのコインの枚数を交換して、じゃんけんをしても場合の数には変わりないため、
	#交換した場合のものもkeyにしてメモ化しておく
	@memo[[coinsA, coinsB, round]] = count
	@memo[[coinsB, coinsA, round]] = count
	return count
end

str = STDIN.gets

nums = str.split(",")

exit if nums.length < 3

isValid = nums.all? do |num|
  num =~ /^[0-9]+$/
end

exit if !isValid

coinsA = nums[0].to_i
coinsB = nums[1].to_i
round = nums[2].to_i

puts janken(coinsA, coinsB, round)