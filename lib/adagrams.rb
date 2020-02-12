# require 'awesome_print'

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

def uses_available_letters?(input, letters_in_hand)
	lih_clone = letters_in_hand.dup
	word = input.split('')
 
	letters_match = []

	word.each do |letter|
		if lih_clone.index(letter) == nil
			break
		else
			lih_clone.slice!(lih_clone.index(letter))
			letters_match << letter
		end
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

# We want a method that returns the score of a given word as defined by the Adagrams game.
# Name this method score_word in adagrams.rb. This method should have the following properties:

# Has one parameter: word, which is a string of characters
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
	
	# p word

	score = 0
	word.each do |letter|
		score_chart.each do |value, array|
			if array.include?(letter.upcase)
				score += value.to_i
			end
		end
	end

	if word.length > 6 && word.length < 11
		score += 8
	end

	return score
end

score_word(word)

# After several hands have been drawn, words have been submitted, checked, scored, and played, we want a way to find the highest scoring word. This method looks at the array of words and calculates which of these words has the highest score, applies any tie-breaking logic, and returns the winning word in a special data structure.

# Add a method called highest_score_from in adagrams.rb. This method should have the following properties:

# Has one parameter: words, which is an array of strings
def highest_score_from(words)
	words_with_scores = []

	words.each do |word|
		words_with_scores.push({:word => word, :score => score_word(word)})
	end 

	highest_score = words_with_scores.max_by do |index|
		index[:score]
	end

	tied_scores = []
	words_with_scores.each do |word|
		if word[:score] == highest_score[:score]
			tied_scores << word
		end
	end

	shortest_word = tied_scores.min_by do |index|
		index[:word].length
	end

	tied_scores.sort_by! do |tied|
		-tied[:word].length
	end

	puts tied_scores


	tied_scores.each do |tied|
		if tied[:word].length == 10 
			return tied
		elsif tied[:word].length == shortest_word[:word].length
			return tied
		else
			next
		end
	end
	
	# check if any length == 10
	#	else find shortest word.length
	# if multiple are shortest
	#		take first


	# highest_score = words_with_scores.max_by(5) do |index|
	# # 	if index[:word].length == 10
	# 		index[:score]
	# 	elsif words_with_scores.min_by do |index|
	# 		p index[:word].length
	# 		index[:score]
	# 		end
	# 	else
	# 		index[:score]
	# 	end
	# end

	

	# words_with_scores.each do |word|
	# 	if word[:word].length == 10
	# 		highest_score = word
	# 	elsif word[:word].length
	# 	word.each do |k, v|
			
	# 	end

	# end


	# word with highest score wins
		#if there is a tie
		# 	word with 10 letters wins
		# 	else then word.length that is shortest wins
		# 	else the word that occurs first (if length and score are equal)
	# end

	# return {:word => "word",
	# :score => 0}
end

highest_score_from(["BBBBBB", "AAAAAAAAAA"])

# In the case of tie in scores, use these tie-breaking rules:
# prefer the word with the fewest letters...
# ...unless one word has 10 letters. If the top score is tied between multiple words and one is 10 letters long, choose the one with 10 letters over the one with fewer tiles
# If the there are multiple words that are the same score and the same length, pick the first one in the supplied list