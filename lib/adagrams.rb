#This program simulates the Adagrams game
def draw_letters
  alphabet = {A: 9, B: 2, C:2, D:4, E:12, F:2, G:3, H:2, I:9, J:1, K:1, L:4, M:2, N:6, O:8, P:2, Q:1, R:6, S:4, T:6, U:4, V:2, W:2, X:1, Y:2, Z:1}
  hand = []
  only_letters = alphabet.keys
  # Builds the user letter pool
  10.times do
    tile = only_letters[rand(only_letters.size)]
    # Checks the availability of the letter
    if alphabet[tile.to_sym] > 0 
      alphabet[tile] -= 1
    elsif alphabet[tile] == 0
      tile = only_letters[rand(only_letters.size)]
    end
    hand << tile.to_s
  end
  return hand
  puts hand
end

def uses_available_letters?(input, letters_in_hand)
  input = input.upcase.split("")
  # Creates a duplicate to maintain integrity of original letters in hand
  comparison_check = letters_in_hand.dup
  input.each do |letter|
    # Checks if the input word complies with available letters
    if comparison_check.include?(letter)
      comparison_check.delete(letter)
    else
      return false
    end
  end
  return true
end

def score_word(word)
  word_letters = word.upcase.split("")
  letter_scores = {A:1, B:3, C:3, D:2, E:1, F:4, G:2, H:4, I:1, J:8, K:5, L:1, M:3, N:1, O:1, P:3, Q:10, R:1, S:1, T:1, U:1, V:4, W:4, X:8, Y:4, Z:10}
  score = 0
  word_letters.each do |letter|
    score += letter_scores[letter.to_sym]
  end
  # Adds 8 more points based on word length in compliance with game rules
  if word_letters.length >= 7
    score += 8
  end
  return score
end

def highest_score_from(words)
  final_array = []
  words.each do |word|
    score = score_word(word)
    final_array << {word: word, score: score}
  end
  highest_score = 0
  winner_word = ""
  winner = nil
  final_array.each do |pair|
    # Declares the winner if any word is 10 characters long
    if pair[:word].length == 10
      winner = pair
      break
    # Finds the winner pair based on its score
    elsif pair[:score] > highest_score 
      highest_score = pair[:score]
      winner_word = pair[:word]
      winner = pair
    # Finds the winner pair when scores are equal based on word length
    elsif pair[:word].length < winner_word.length && pair[:score] == highest_score
      winner_word = pair[:word]
      winner = pair
    # Finds the winner pair when scores are equal based on word order
    elsif pair[:word].length == winner_word.length && pair[:score] == highest_score 
      winner = winner
    end
  end
  return winner
  p winner
end

def in_dict?(input)
  CSV.open("assets/dictionary-english.csv", "r").each do |word|
    return true if word.include?(input.downcase)
  end
  return false
end

