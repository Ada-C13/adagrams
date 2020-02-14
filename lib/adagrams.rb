# Adagrams
# Lak & Diana

# Dependencies
require 'awesome_print'
require 'csv'

# Method to create letter pool 
def create_letter_pool(letter, quantity)
  index = 0
  letter_pool = []

  letter.each_with_index do |letter, index|
    letter_pool.fill(letter, letter_pool.size, quantity[index])
  end
  return letter_pool
end

# Wave (1) - method to draw 10 random letters
def draw_letters
    letter = ('A'..'Z').to_a
    quantity = [9, 2, 2, 4, 12, 2, 3, 2, 9, 1, 1, 4, 2, 6, 8, 2, 1, 6, 4, 6, 4, 2, 2, 1, 2, 1]
   
  # Use the create_letter_pool method
    create_letter_pool(letter, quantity)
    letter_pool_array = create_letter_pool(letter, quantity)
    
  # Shuffle the letter pool
    letter_pool_array = letter_pool_array.shuffle()
    letters = letter_pool_array.sample(10) # Not sure if it will have more than 2 Cs
    letter.join(', ')
    return drawn_letters = letters
end

# Wave (5) - method to verify if word is a valid word in the English dictionary
def is_in_english_dict? (input)
  dictionary = CSV.read('assets/dictionary-english.csv')
  dictionary = dictionary.flatten
  is_valid_word = dictionary.include?(input) 
  return is_valid_word
end

# Wave (2)- method to check whether word by user is in drawn letters
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

# Wave (3) - method to calculate score
def score_word(word)
  word = word.upcase.chars

  # scoring
  if word.empty? == true # nil case or empty string
    score_word = 0
  else
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

      # > 7 letter bonus
      if word.length >= 7
        score_word = score_word + 8
      else
        score_word = score_word
      end
  end
  return score_word 
end

# Wave (4)- method to calculate winning word
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
    #tie rules
    case
    when word[:score] > highest_score
      highest_score = word[:score]
      highest_word = word[:word]
    # test 7 - tied score and same length words, prefers the first word
    when (word[:score] == highest_score) && ((word[:word]).length == highest_word.length)
      highest_score = highest_score
      highest_word = highest_word
    # test 5 & 6 - tied score, prefers most the word with 10 letters regardless of order
    when (word[:score] == highest_score) && ((word[:word]).length == 10)
      highest_score = word[:score]
      highest_word = word[:word]
    when (word[:score] == highest_score) && (highest_word.length == 10)
      highest_score = highest_score
      highest_word = highest_word
    # test 3 & 4 - tied score, prefers the word with fewer letters regardless of order
    when (word[:score] == highest_score) && ((word[:word]).length < highest_word.length)
      highest_score = word[:score]
      highest_word = word[:word]
    when (word[:score] == highest_score) && ((word[:word]).length > highest_word.length)
      highest_score = highest_score
      highest_word = highest_word
    end
  end
  
  best_word[:word] = "#{highest_word}"
  best_word[:score] = highest_score

  return best_word

end

