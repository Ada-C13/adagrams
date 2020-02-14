# Wave 1 - creates letter hand
def draw_letters 
  rand_letters = []
  letters = ["a", "a", "a", "a", "a", "a", "a", "a", "a", "b", "b", "c", "c", "d", "d", "d", "d", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "f", "f", "g", "g", "g", "h", "h", "i", "i", "i", "i", "i", "i", "i", "i", "i", "j", "k", "l", "l", "l", "l", "m", "m", "n", "n", "n","n", "n", "n", "o", "o", "o", "o", "o", "o", "o", "o", "p", "p", "q", "r", "r", "r", "r", "r", "r", "s", "s", "s", "s", "t", "t", "t", "t", "t", "t", "u", "u", "u", "u", "v", "v", "w", "w", "x", "y", "y", "z"]
  rand_letters = letters.sample(10)
  return rand_letters
end

# Wave 2 - checks that input is valid
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

# Wave 3 - scores input
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

# returns a hash of word scores
# may be useful in determining when to run tie_breaker
# if score_storage_hash.values != score_storage_hash.values.uniq, 
# then run tie_breaker?
def word_scores(words)
  score_storage_hash = {}
  words.each do |word|
    score_storage_hash[word] = score_word(word)   
  end
  return score_storage_hash
end

# possible tie break method to invoke in highest_score_from method?
# ALL THE SCORES IN HERE ARE THE SAME SO THE SCORE DOES NOT MATTER
def tie_breaker(words)
  ten_letter_word_array = []
  tie_scores_array = []
  winning_hash = {}
  
  word_scores(words).each do |word, score|
    if word.length == 10
      ten_letter_word_array << word
    else
      tie_scores_array << word
    end
    
    if ten_letter_word_array.count > 0
      winning_hash[:word] = ten_letter_word_array[0]
      winning_hash[:score] = score
    else 
      winning_hash[:word] = tie_scores_array.min_by { |word| word.length }
      winning_hash[:score] = score
    end
  end
  
  return winning_hash
end

# Wave 4 - determines winning word, accounting for ties
def highest_score_from(words)
  high_score_hash = {}
  high_score = 0
  winning_word = ""
  tie_breaking_array = []
  
  # look at each word, invoke score_word method, set highest score as winning_word
  words.each do |word|
    if score_word(word) > high_score
      high_score = score_word(word)
      winning_word = word
    end   
  end
  
  if word_scores(words).values != word_scores(words).values.uniq
    # invoke tie_breaking method
    # if there are tied scores,
    # invoke the tie score method on the words hash
    tie_winner = tie_breaker(words) # this is a hash
    winning_word = tie_winner[:word]
    high_score = tie_winner[:score]
  end
    
  high_score_hash[:score] = high_score
  high_score_hash[:word] = winning_word 
  return high_score_hash
end
  
# words = ['WWW', 'MMMM']
# best_word = highest_score_from words

# puts best_word
  
  
  
  
  # if tie_breaking_array[0].length > tie_breaking_array[1].length
  #   winning_word = tie_breaking_array[1]
  # elsif tie_breaking_array[1].length > tie_breaking_array[0].length
  #   winning_word = tie_breaking_array[0]
  # elsif tie_breaking_array[0].length == 10
  #   winning_word = tie_breaking_array[0]
  # elsif tie_breaking_array[1].length == 10
  #   winning_word = tie_breaking_array[1]
  # end
  
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
  
  #Things we deleted that were or were not working :)
  # look at each word again, if there are any words that have a 
  # score equal to the high score, store those in a tie breaking array
  # should we make a new "tie break" method?
  # words.each do |word|
  #   if score_word(word) == high_score
  #     tie_breaking_array << word
  #   end
  # end
  
  # # need to add logic that only runs this if tie_breaking_array 
  # # length is greater than 1 (which may be a good reason to make another method!
  # ten_letter_words = []
  # shortest_words = [] # this would be more clear as tie_score_words
  # tie_breaking_array.each do |word|
    
  #   if word.length == 10
  #     ten_letter_words << word
      
  #     shortest_words << shortest_words.min
  #   end
  # end
  
  # if ten_letter_words[0] (# is truthy)
  #   winning_word = ten_letter_word[0]
  # else winning_word = shortest_words.min_by { |word| word.length }
  # end