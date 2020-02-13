# Wave 1

# create method draw_letters 
# no parameters, returns array of 10 strings, each 1 letter player has drawn randomly


def draw_letters 
  rand_letters = []
  letters = ["a", "a", "a", "a", "a", "a", "a", "a", "a", "b", "b", "c", "c", "d", "d", "d", "d", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "f", "f", "g", "g", "g", "h", "h", "i", "i", "i", "i", "i", "i", "i", "i", "i", "j", "k", "l", "l", "l", "l", "m", "m", "n", "n", "n","n", "n", "n", "o", "o", "o", "o", "o", "o", "o", "o", "p", "p", "q", "r", "r", "r", "r", "r", "r", "s", "s", "s", "s", "t", "t", "t", "t", "t", "t", "u", "u", "u", "u", "v", "v", "w", "w", "x", "y", "y", "z"]
  rand_letters = letters.sample(10)
  return rand_letters
end

# print draw_letters

# 1st attempt wave 2
# def uses_available_letters?(input, letters_in_hand) # input = what the user enters; letters_in_hand = random letters from previous method
#   # if letters in hand includes all letters in input 
#   # and the counts of letters in inputs is less than
#   # or equal to the counts of letters in letters_in_hand
#   # returns true
#   split_input = input.downcase.split(//)

#   split_input.each do |letter|
#     letter_count = letter.count
#     letter_in_hand_count = letter.count
#       if letter_count <= letter_in_hand_count 
#         return true
#       else 
#         return false
#       end
#     end

  
#   check_input_letters = (split_input - letters_in_hand)
#   if check_input_letters.empty? # && check_input_quantity 
#     return true
#   end

  

# end

# Wave 2
def uses_available_letters?(input, letters_in_hand)
  letters_in_hand_copy = letters_in_hand.dup
  input.split('').each do |letter|
    if letters_in_hand_copy.include? (letter)
      letters_in_hand_copy.slice!(letters_in_hand_copy.index(letter))
    else 
      return false
    end
  end 
  return true 
end


# Wave 3 

def score_word(word)
  score = 0
  if word.length > 6
    score += 8
  end
  word = word.upcase.split('')
  # split word into characters
  word.each do |letter|
    # use a c statement to add points to score variable
    case letter
    when "A", "E", "I", "O", "U", "L", "N", "R", "S", "T"
      score += 1
    when "D", "G"
      score += 2
    when "B", "C", "M", "P"
      score += 3
    when "F", "H", "V", "W", "Y"
      score += 4
    when "K"
      score += 5
    when "J", "X"
      score += 8
    when "Q", "Z"
      score += 10
    end
  end
  return score
end

# Wave 4
def highest_score_from(words)
high_score_hash = {}
high_score = 0
winning_word = ""
tie_breaking_array = []

  words.each do |word|
    if score_word(word) > high_score
      high_score = score_word(word)
      winning_word = word
    end   
  end
  
  words.each do |word|
    if score_word(word) == high_score
      tie_breaking_array << word
    end
  end

  ten_letter_words = []
  shortest_words = []
  tie_breaking_array.each do |word|
    
    if word.length == 10
      ten_letter_words << word
    
      shortest_words << shortest_words.min
    end
  end

  if ten_letter_words.empty?
    winning_word = shortest_words.first
  end

  high_score_hash[:score] = high_score
  high_score_hash[:word] = winning_word
  return high_score_hash
end



# if tie_breaking_array[0].length > tie_breaking_array[1].length
#   winning_word = tie_breaking_array[1]
# elsif tie_breaking_array[1].length > tie_breaking_array[0].length
#   winning_word = tie_breaking_array[0]
# elsif tie_breaking_array[0].length == 10
#   winning_word = tie_breaking_array[0]
# elsif tie_breaking_array[1].length == 10
#   winning_word = tie_breaking_array[1]
# end