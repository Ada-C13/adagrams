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

	# p score
end

score_word(word)

# Returns an integer representing the number of points
# Each letter within word has a point value. The number of points of each letter is summed up to represent the total score of word
# Each letter's point value is described in the table below
# If the length of the word is 7, 8, 9, or 10, then the word gets an additional 8 points