@memo = {}

#本をある日ちょうどで読み切る通り数をカウント
def book(pages, days)
	return @memo[[pages, days]] if @memo.has_key?([pages, days])
	return 1 if days == 1

	i = 1
	count = 0
	#引数の日にち分にそれぞれ1ページずつ加算する
	#右辺以上にしておくのは、各日付で差をつけられるようにするため
	while (pages - days * i) >= days * (days - 1) / 2
		count += book(pages - days * i, days - 1)
		i += 1
	end
	@memo[[pages, days]] = count
	return count
end

str = STDIN.gets

nums = str.split(",")

exit if nums.length < 2

isValid = nums.all? do |num|
  num =~ /^[0-9]+$/
end

exit if !isValid

pages = nums[0].to_i
days = nums[1].to_i

result = 0

#設定された日にち以内全ての通りをカウントするため
(1..days).each do |i|
	result += book(pages, i)
end

puts result