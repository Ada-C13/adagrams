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
  
  word.each do |letter|
    
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

# Wave 4 - method for storing all user input
def word_scores(words)
  score_storage_hash = {}
  words.each do |word|
    score_storage_hash[word] = score_word(word)   
  end
  return score_storage_hash
end

# Wave 4 - method for breaking ties
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

# Wave 4 - determines highest score, and if needed invokes tie_breaker
def highest_score_from(words)
  high_score_hash = {}
  
  high_score = word_scores(words).max_by { |word, score| score }[1]
  winning_word = word_scores(words).max_by { |word, score| score }[0]

  if word_scores(words).values != word_scores(words).values.uniq
    tie_winner = tie_breaker(words) 
    winning_word = tie_winner[:word]
    high_score = tie_winner[:score]
  end
    
  high_score_hash[:score] = high_score
  high_score_hash[:word] = winning_word 
  return high_score_hash
end