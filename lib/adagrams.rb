def draw_letters
	letter_pool = []
	letter_choices = Hash( A: 9, B: 2, C: 2, D:4, E: 12, F: 2, G: 3, H: 2, I: 9, J: 1, K: 1, L: 4, M: 2, N: 6, O: 8, P: 2, Q: 1, R: 6, S: 4, T: 6, U: 4, V: 2, W: 2, X: 1, Y: 2, Z: 1)
	letter_choices.map do |letter, number|
		letter_pool << (letter.to_s * number).split(//)
	end
	letter_pool = letter_pool.flatten
	user_hand = letter_pool.sample(10)
	return user_hand
end



def uses_available_letters?(input, letters_in_hand)
	split_input = input.upcase.split(//)

	letters_in_hand.each do |letter|
		split_input.delete_at(split_input.index(letter)) unless split_input.index(letter).nil?
	end
	return split_input.empty?
end


def score_word(word)
	score_count = 0
	
	split_input = word.upcase.split(//)

	split_input.each do |letter|
		case letter
		when "A", "E", "I", "O", "U", "L", "N", "R", "S", "T"
			score_count += 1
		when "D", "G"
			score_count += 2
		when "B", "C", "M", "P"
			score_count += 3
		when "F", "H", "V", "W", "Y"
				score_count += 4
		when "K"
			score_count += 5
		when "J", "X"
			score_count += 8
		when "Q", "Z"
			score_count += 10
		end
	end
	score_count += 8 if word.length >= 7
	return score_count
end

def highest_score_from(words)
	word_score_array = Array.new
	word_score_hash = Hash.new
	highest_score = 0
	winning_word = ""
	shortest_word_length = 0

	words.each do |word|
		score = score_word(word)
		word_score_hash[word] = score
		word_score_array << word_score_hash
	end

	word_score_array = word_score_array.uniq

	word_score_array.each do |set|
		highest_score = set.values.max

		tie = set.select { |k, v| v == highest_score}
		if tie.length >= 2
			tie.each do |word, score|
				if word.length > shortest_word_length 
					if shortest_word_length == 0
						shortest_word_length = word.length
						winning_word = word
					elsif word.length == 10
						shortest_word_length = word.length
						winning_word = word
					end

				elsif word.length < shortest_word_length
					if shortest_word_length == 10
						nil
					else
						winning_word = word
					end

				elsif word.length == shortest_word_length 
					winning_word = set.key(highest_score)
				end
			end
		else 
			winning_word = set.key(highest_score)
		end
	end
	return winning_hash = {:word => winning_word, :score => highest_score}
end




