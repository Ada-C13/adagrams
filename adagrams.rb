def draw_letters
  pool = {
    "a" => 9,
    "b" => 2,
    "c" => 2,
    "d" => 4,
    "e" => 12,
    "f" => 2,
    "g" => 3,
    "h" => 2,
    "i" => 9,
    "j" => 1,
    "k" => 1,
    "l" => 4,
    "m" => 2,
    "n" => 6,
    "o" => 8,
    "p" => 2,
    "q" => 1,
    "r" => 6,
    "s" => 4,
    "t" => 6,
    "u" => 4,
    "v" => 2,
    "w" => 2,
    "x" => 1,
    "y" => 2,
    "z" => 1
  }
  user_letters = []
  10.times do
    letter = pool.keys.sample(1)
    letter = letter[0].to_s
    user_letters << letter
    pool[letter] -= 1
    if pool[letter] == 0
      pool.delete(letter)
    end
  end
  return user_letters
end

# player_letters = draw_letters
# puts player_letters
# player_input = gets.chomp

# def uses_available_letters?(input, letters_in_hand)
#   input_letters = input.split(//)
#   print input_letters
#   input_letters.each do |letter|
#     if letters_in_hand.include?(letter)
#       letters_in_hand.delete(letter)
#     else
#       puts "You do not have the letters to create that word. Please enter a new word using the letters: #{letters_in_hand}"
#       return false
#       exit
#     end
#   end
#   return true
# end

# true_or_false = uses_available_letters?(player_input, player_letters)
# puts true_or_false