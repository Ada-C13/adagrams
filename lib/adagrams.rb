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

p draw_letters

def uses_available_letters(input, letters_in_hand)
	split_input = input.split(//)
	p letter_check = (split_input - letters_in_hand)
	output = letter_check.empty?
	p output
end

uses_available_letters("a", draw_letters)