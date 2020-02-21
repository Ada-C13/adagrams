def display_welcome_message
  puts "Welcome to Adagrams!"
  puts "Let's draw 10 letters from the letter pool..."
end

def display_drawn_letters(letters)
  puts "You have drawn the letters:"
  puts letters.join(', ')
end

def draw_letters 
  all_letters = {A: 9, B: 2, C: 2, D: 4, E: 12, F: 2, G: 3, H: 2, I: 9, J: 1, K: 1, L: 4, M: 2, N: 6, O: 8, P: 2, Q: 1, R: 6, S: 4, T: 6, U: 4, V: 2, W: 2 , X: 1, Y: 2, Z: 1}
  
  letter_pool = []
  all_letters.each do |letter,count|
    letter_pool.concat(Array.new(count) { letter.to_s })
  end  
  hand_letters = letter_pool.sample(10)
  return hand_letters
end 

def display_game_instructions
  puts "Please input a word that only uses the letters from the letter bank"
end

def display_needs_valid_input_message
  puts "You entered in a word that contains characters not in the letter bank"
  display_game_instructions
end

def display_score(score)
  puts "Your submitted anagram scored #{score} points"
end

def uses_available_letters?(input, letters_in_hand)
  letter_bank = letters_in_hand.dup 
  
  input.split(//).each do |l|
    if letter_bank.include?(l)
      letter_bank.delete_at(letter_bank.index(l))
    else 
      return false 
    end 
  end 
  return true 
end 

def score_word(word)

 letters = word.upcase.split(//)
  score_pool = {["A", "E", "I", "O", "U", "L"," N", "R", "S", "T"]=> 1,["D", "G"] => 2, ["B", "C", "M", "P"] => 3,["F", "H", "V", "W", "Y"]=> 4, ["K"] => 5, ["J", "X"] => 8, ["Q", "Z"] => 10}

  score = 0

  letters.each do |l|
    score_pool.each do |array, points|
      if array.include?(l)
        score += points
      end 
    end 
  end 
  if letters.size >=7 && letters.size <=10
    score += 8
  end
  return score
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

def run_game
  played_words = []

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
    played_words << user_input_word

    display_score(score)

    display_retry_instructions
    should_continue = get_user_input == "y"
  end

  display_highest_score(highest_score_from(played_words))
  display_goodbye_message
end







