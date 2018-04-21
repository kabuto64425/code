#変数名で、位置の表し方が以下のように異なる。
#panel:アタック25のパネルの番号に対応
#position:縦をy、横をx、左上を[0, 0]として場所を表す

#あるpositionの上から時計回りに周囲の方向を2つの配列を使って表す
@vecy = [-1,-1,0,1,1,1,0,-1]
@vecx = [0,1,1,1,0,-1,-1,-1]

#panelの配列をpositionの配列に変換
def convertToPositions(panels)
	result = []
	panels.each do |panel|
		y = (panel - 1) / 5
		x = (panel - 1) % 5
		result << [y,x]
	end
	return result
end

#positionの配列をpanelの配列に変換（ついでに番号順にソート）
def convertToPanels(positions)
	result = []
	positions.each do |position|
		result << position[0] * 5 + position[1] + 1
	end
	return result.sort
end

#隣接したパネルを求める
#とられたpositonの周囲のpositionを求める
#そこから範囲外のpositionは除外
#すでに取られているpositionも除外
#求めるpositionに重複が無いようにする
def getNeighboringPositions(positions)
	result = []
	positions.each do |position|
		(0..7).each do |vec|
			y = position[0] + @vecy[vec]
			x = position[1] + @vecx[vec]
			next if y < 0 || y > 4
			next if x < 0 || x > 4
			stepPos = [y, x]
			next if positions.include?(stepPos)
			result |= [stepPos]
		end
	end
	return result
end

#挟めるpositionを求める
#自分のpositionの1つから、挟めるpositionを各方向から求める
#求めるpositionに重複が無いようにする
def getBetweenPositions(myPositions, otherPositions)
	result = []
	myPositions.each do |position|
		(0..7).each do |vec|
			betweenPosition = getBetweenPosition(position, vec, myPositions, otherPositions)
			result |= [betweenPosition] if !betweenPosition.empty?
		end
	end
	return result
end

#自分のあるpositionと方向に進み、挟めるpositionが無いか順に調べる
#ある場合は挟めるposition、無い場合は空配列を返す
#positionから、ある方向に、取られていないpositionが出てくるまで進み、そのpositionを返す
#ただし
#範囲外だと挟めない
#自分のpositionがあると挟めない(妨げになる)
#2歩以上進んでいないと挟めない
#そのため、この条件のいずれかを満たすと空配列になる
def getBetweenPosition(position, vec, myPositions, otherPositions)
	y = position[0]
	x = position[1]
	flag = false
	while true
		y += @vecy[vec]
		x += @vecx[vec]
		
		break if y < 0 || y > 4
		break if x < 0 || x > 4
		break if myPositions.include?([y,x])
		if otherPositions.include?([y,x])
			flag = true
			next
		end
		
		if flag
			return [y, x]
		end
		break
	end
	return []
end

#次に挟めるpositionを求める
#隣接したpositionから、あるpositionを仮に自分がとったと仮定した場合、
#1つでも挟めることが出来た場合、そのpositionを結果に加える
def getNextBetweenPositions(neighboringPositions, myPositions, otherPositions)
	result = []
	neighboringPositions.each do |position|
		(0..7).each do |vec|
			if !getBetweenPosition(position, vec, myPositions, otherPositions).empty?
				result |= [position]
				break
			end
		end
	end
	return result
end

players = ["R","B","W","G"]
startPanel = [13]
positionsHash = {}

players.each do |player|
	str = STDIN.gets
	panels = str.split(",").slice(1..-1).map{|numStr| numStr.to_i}
	positionsHash[player] = convertToPositions(panels)
end

neighboringPositions = getNeighboringPositions(positionsHash.values.inject(:|))

#1:挟めるときは挟む
#2:挟めないときは次にはなめるようにとる
#3:それ以外は隣接したパネルをとる
#4:例外としてまだとられたパネルが無いと13をとる
#この順で各プレイヤーがとれるパネルを調べていき、1枚でもとれるパネルがある場合はそのパネルを結果として出力
players.each do |player|
	myPositions = positionsHash[player]
	otherPositions = positionsHash.select{|key, value| !player.include?(key)}.values.inject(:|)
	result = getBetweenPositions(myPositions, otherPositions)
	if result.empty?
		result = getNextBetweenPositions(neighboringPositions, myPositions, otherPositions)
	end
	if result.empty?
		result = neighboringPositions
	end
	if result.empty?
		result = convertToPositions(startPanel)
	end
	puts player +"," + convertToPanels(result).to_s.delete("[").delete("]").delete(" ")
end