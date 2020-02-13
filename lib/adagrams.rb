## WAVE 1 ##

def draw_letters
	letters = {A: 9, B: 2, C: 2, D: 4, E: 12, F: 2, G: 3, H: 2, I: 9, J: 1, K: 1, L: 4, M: 2, N: 6, O: 8, P: 2, Q: 1, R: 6, S: 4, T: 6, U: 4, V: 2, W: 2, X: 1, Y: 2, Z: 1}

	pool_of_letters = []
	
	letters.each do |letter, amount|
		amount.times do
			pool_of_letters << letter.to_s
		end
	end

	hand = []

	10.times do 
		letter = pool_of_letters.sample
		pool_of_letters.slice!(pool_of_letters.index(letter))
		hand << letter
	end
	
	hand.each do |letter|
		pool_of_letters << letter
	end

	return hand.sort
end

hand = draw_letters
puts "Your hand is #{hand}."

## WAVE 2 ##

def uses_available_letters?(input, letters_in_hand)
	lih_clone = letters_in_hand.dup
	word = input.split('')
 
	letters_match = word.map do |letter|
		break if lih_clone.index(letter) == nil
		lih_clone.slice!(lih_clone.index(letter))
		letter
	end

	if word == letters_match
		word.each do |letter|
			lih_clone << letter
		end		
		return true
	else
		return false
	end

end

puts "What is your word?"
word = gets.chomp.upcase
uses_available_letters?(word, hand)

## WAVE 3 ##

def score_word(word)
	score_chart = {
		1 => ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"],
		2 => ["D", "G"], 
		3 => ["B", "C", "M", "P"],
		4 => ["F", "H", "V", "W", "Y"],
		5 => ["K"],
		8 => ["J", "X"],
		10 => ["Q", "Z"]
	}

	word = word.split('')
	
	score = 0
	word.each do |letter|
		score_chart.each do |value, array|
			score += value.to_i if array.include?(letter.upcase)
		end
	end

	score += 8 if word.length > 6 && word.length < 11
	
	return score
end

score_word(word)

## WAVE 4 ##

def highest_score_from(words)
	words_with_scores = {}

	words.each do |word|
		words_with_scores[word] = score_word(word)
	end 

	highest_score = words_with_scores.max_by do |word, score|
		score
	end

	tied_scores = {}
	words_with_scores.each do |word, score|
		tied_scores[word] = score if score == highest_score[1]
	end

	shortest_length = 0
	tied_scores.min_by do |word, score|
		shortest_length = word.length
	end

	# tied_scores.sort_by! do |word, score|
	# 	-word.length
	# end

	tied_scores.each do |word, score|
		hash = {word => score}
		if word.length == 10 
			return hash
		elsif word.length == shortest_length
			return hash
		else
			next
		end
	end

end

highest_score_from(["potato", "banana", "dog"])

## WAVE 5 ##