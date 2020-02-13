# Creating letter pool
letter = ('A'..'Z').to_a
quantity = [9, 2, 2, 4, 12, 2, 3, 2, 9, 1, 1, 4, 2, 6, 8, 2, 1, 6, 4, 6, 4, 2, 2, 1, 2, 1 ]

def create_letter_pool(letter, quantity)
  index = 0
  letter_pool = []
  letter.each_with_index do |letter, index|
    letter_pool.fill(letter, letter_pool.size, quantity[index])
  end
  return letter_pool
end
letter_pool_array = create_letter_pool(letter, quantity)




# Wave (1)
# Method to draw 10 random letters
def draw_letters
  # Welcome message
    puts "Welcome to Adagrams!"
    puts "Let's draw 10 letters from the letter pool..."
    puts "You have drawn the letters:"
    
    letter = ('A'..'Z').to_a
    quantity = [9, 2, 2, 4, 12, 2, 3, 2, 9, 1, 1, 4, 2, 6, 8, 2, 1, 6, 4, 6, 4, 2, 2, 1, 2, 1 ]
   
  # Use the create_letter_pool method
    create_letter_pool(letter, quantity)
    letter_pool_array = create_letter_pool(letter, quantity)
    
  # Shuffle the letter pool
    letter_pool_array = letter_pool_array.shuffle()
    letters = letter_pool_array.sample(10) # Not sure if it will have more than 2 Cs
    letter.join(', ')
    return drawn_letters = letters
end
drawn_letters = draw_letters
puts drawn_letters.join(', ')


# Wave (2)
puts "Please provide a word that only uses the letters from the letter bank: "
test_word = gets.chomp

# method to check whether word by user is in drawn letters
def uses_available_letters? (input, letters_in_hand)
  input = input.upcase.chars
  # make copy of drawn letters
  dl_copy = letters_in_hand.dup

  # if letter of input = letter in drawn letters, remove letter in drawn letters
  # continue to compare rest of letters to drawn letters
  # times_true array used to determine if word is valid
  times_true = []
  input.each do |letter|
    if dl_copy.include?(letter) == true
      dl_copy.delete_at(dl_copy.index(letter))
      times_true << "true"
    else
      times_true << "false"
    end
  end

  if times_true.count("true") == input.length
    is_valid = true
  else
    is_valid = false
  end
  return is_valid
end

puts uses_available_letters?(test_word, drawn_letters)

# Wave (3)
# method to calculate score
def score_word(word)
  word = word.upcase.chars

  if word.empty? == true # nil case or empty string
    score_word = 0
  else
      # scoring
      score_word = word.map do |letter|
        case letter
        when "A", "E", "I", "O", "U", "L", "N", "R", "S", "T"
          1
        when "D", "G"
          2
        when "B", "C", "M", "P"
          3
        when "F", "H", "V", "W", "Y"
          4
        when "K"
          5
        when "J", "X"
          8
        when "Q", "Z"
          10
        else
          0
        end
      end
      
      # calculate total score
      score_word = score_word.inject(:+)

      if word.length >= 7
        score_word = score_word + 8
      else
        score_word = score_word
      end
  end
  return score_word 
end

# hash to hold words and scores
# master array for Wave 4 -> words
words = []
scores = []

words << test_word

score = score_word(test_word)
scores << score

# Do ya want to play again prompt
# put as method
# repeat through game wave 1 - 3

# use until loop/while 
# use keyword arguments? example, how many times would you like to play again?
# def play_again (how_many_times: )
puts "Would you like to play again? Enter y to play again."
answer = gets.chomp

while answer == "y"
  # Wave 1
  drawn_letters = draw_letters
  puts drawn_letters.join(', ')

  puts "Please provide a word that only uses the letters from the letter bank: "
  test_word = gets.chomp

  # Wave 2
  puts uses_available_letters?(test_word, drawn_letters)

  # Wave 3
  
  words << test_word
  
  score = score_word(test_word)
  scores << score

  # Prompt again
  puts "Would you like to play again? Enter y to play again."
  answer = gets.chomp

end

print words
# Wave (4)
# play multiple times
# array of words

# score_tracker = {game1:{word, score}, game2:{word,score}}


def highest_score_from (words)
  # hash with all words and scores
  all_words_score = words.map do |word|
    score = score_word(word)
    {
      :word => word,
      :score => score
    }
  end
  
  # highest score calculation
  highest_score = 0
  highest_word = ""
  best_word = {}
  all_words_score.each do |word|
    if word[:score] > highest_score
        highest_score = word[:score]
        highest_word = word[:word] 
    else word[:score] == highest_score
      # tie rules
      # `conditionals` galore:
      # prefer word with fewest letters
      # if word has 10 letters, top word is the one with more tiles wins
      # multiple words of same length, pick first one
      if (word[:word]).length == 10
        highest_score = word[:score]
        highest_word = word[:word]
      elsif ((word[:word]).length < (highest_word.length)) && ((word[:word]).length != 10)
        highest_score = word[:score]
        highest_word = word[:word]
      # else (word[:word]).length < highest_word.length
      #   highest_word = word[:word]
      elsif (word[:word]).length == (highest_word.length)
        highest_score = highest_score
        highest_word = highest_word
      else
        highest_score = highest_score
        highest_word = highest_word
      end
    end

  end
  
  best_word[:word] = "#{highest_word}"
  best_word[:score] = highest_score

  return best_word

end

puts highest_score_from(words)