require 'csv'

## WAVE 1 - build a hand of 10 random letters from a pool ##
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

## WAVE 2 - check if an input word only uses words contained within the hand ##
def uses_available_letters?(input, letters_in_hand)
	lih_clone = letters_in_hand.dup
	word = input.upcase.split('')
 
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

## WAVE 3 - returns the score of a given word ##
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

## WAVE 4 - find the highest scoring word ##
def highest_score_from(words)
	words_with_scores = words.map do |word|
		{:word => word, :score => score_word(word)}
	end 

	highest_score = words_with_scores.max_by do |index|
		index[:score]
	end

	tied_scores = []
	words_with_scores.each do |word|
		tied_scores << word if word[:score] == highest_score[:score]
	end

	return tied_scores[0] if tied_scores.length == 1

	shortest_length = tied_scores.min_by do |index|
		index[:word].length
	end

	tied_scores.sort_by! do |tied|
		-tied[:word].length
	end

	tied_scores.each do |tied|
		case tied[:word].length
			when 10
				return tied
			when shortest_length[:word].length
				return tied
			else
				next
		end
	end
end

## WAVE 5 - verify that the input word is valid against the english dictionary ##
def is_in_english_dict?(input)	
	input = input.downcase

	dictionary = CSV.read('assets/dictionary-english.csv', headers: true).map do |word|
		word[0]
	end

	dictionary_grouped = dictionary.group_by do |word|
		word[0]
	end

	return dictionary_grouped[input[0]].include?(input)
end