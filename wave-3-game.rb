require_relative 'lib/adagrams'

def display_welcome_message
  puts "Welcome to Adagrams!"
end

def display_drawn_letters(letters)
  puts "You have drawn the letters:"
  puts letters.join(', ')
end

def display_game_instructions
  puts "Please input your submission for the longest anagram you can come up with"
end

def display_needs_valid_input_message
  puts "You entered in a word that contains characters not in the letter bank"
  display_game_instructions
end

def score_word(word)
  word_letters = Array.new(word.split(""))
  letter_scores = {A:1, B:3, C:3, D:2, E:1, F:4, G:2, H:4, I:1, J:8, K:5, L:1, M:3, N:1, O:1, P:3, Q:10, R:1, S:1, T:1, U:1, V:4, W:4, X:8, Y:4, Z:10}
  score = 0
  word_letters.each do |letter|
    #p letter.to_sym
    score += letter_scores[letter.to_sym]
  end
  return score
end

def display_score(score)
  puts "Your submitted anagram scored #{score} points"
end

def display_retry_instructions
  puts "Should we play another round?"
  puts "Enter y to replay"
end

def display_goodbye_message
  puts "Thanks for playing Adagrams!"
end

def get_user_input
  gets.chomp.upcase
end

def uses_available_letters?(get_user_input, letters_in_hand)
  word_letters = Array.new(get_user_input.split(""))
  word_letters.difference(letters_in_hand).empty?
end

def run_game
  display_welcome_message

  should_continue = true

  while should_continue
    puts "Let's draw 10 letters from the letter pool..."

    letter_bank = draw_letters
    display_drawn_letters(letter_bank)

    display_game_instructions

    user_input_word = get_user_input

    while ( !(uses_available_letters?(user_input_word, letter_bank)) )
      display_needs_valid_input_message
      user_input_word = get_user_input
    end

    score = score_word(user_input_word)

    display_score(score)

    display_retry_instructions
    should_continue = get_user_input == "y"
  end

  display_goodbye_message
end

def draw_letters
  alphabet = {A: 9, B: 2, C:2, D:4, E:12, F:2, G:3, H:2, I:9, J:1, K:1, L:4, M:2, N:6, O:8, P:2, Q:1, R:6, S:4, T:6, U:4, V:2, W:2, X:1, Y:2, Z:1}
  hand = []
  10.times do |letter, count|
    tile = alphabet.keys.sample().to_sym
    if alphabet[tile] > 0 
        alphabet[tile] -= 1
      elsif alphabet[tile] == 0
        tile = alphabet.key.sample()
      end
    hand << tile.to_s
  end
  return hand
  # puts alphabet
  puts hand
end

run_game
