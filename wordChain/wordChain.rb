@country = ["Brazil","Croatia","Mexico","Cameroon",
			"Spain","Netherlands","Chile","Australia",
			"Colombia","Greece","Cote d'Ivoire","Japan",
			"Uruguay","Costa Rica","England","Italy",
			"Switzerland","Ecuador","France","Honduras",
			"Argentina","Bosnia and Herzegobina","Iran",
			"Nigeria","Germeny","Portugal","Ghana",
			"USA","Belgium","Algeria","Russia",
			"Korea Republic"]

@is_used = Array.new(@country.size, false)

#32通りを総当たりで考える。
#余裕がある時に最長しりとり問題の最適化を考えてみる。
def search(root, depth)
	is_last = true
	@country.each_with_index do |c, i|
		if c[0] == root[-1][-1].upcase then
			if !@is_used[i]
			    #まだ続きが存在している場合
				is_last = false
				@is_used[i] = true
				search(root + [c], depth + 1)
				@is_used[i] = false
			end
		end
	end
	
	if is_last
		@max_depth = [@max_depth, depth].max
		@root = root if root.size > @root.size
	end
end

@max_depth = 0
@root = []

@country.each_with_index do |c,i|
	@is_used[i] = true
	search([c], 1)
	@is_used[i] = false
end

puts @max_depth
puts @root.to_s