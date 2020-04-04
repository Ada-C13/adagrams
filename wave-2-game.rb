require_relative 'lib/adagrams'

def display_welcome_message
  puts "Welcome to Adagrams!"
end

def display_drawn_letters(letters)
  puts "You have drawn the letters:"
  puts letters.join(', ')
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

def display_retry_instructions
  puts "Should we play another round?"
  puts "Enter y to replay"
end

def display_goodbye_message
  puts "Thanks for playing Adagrams!"
end

def get_user_input
  gets.chomp
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
    
    display_retry_instructions
    should_continue = get_user_input == "y"
  end
  
  display_goodbye_message
end

run_game
