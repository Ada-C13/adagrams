# Program that randomly displays 10 letters. 
# Given those 10 letters, make words and recieve a score. 
# Upon exiting, recieve file score and highest point word.

# Access english dictionary
require "csv"
ENGLISH_DICT = CSV.read("assets/dictionary-english.csv")

# Wave 1
# Create hash with letters available and randomly sample 10 for user
def draw_letters
  all_tiles = {
    A: 9, B: 2, C: 2, D: 4, E: 12,
    F: 2, G: 3, H: 2, I: 9, J: 1,
    K: 1, L: 4, M: 2, N: 6, O: 8,
    P: 2, Q: 1, R: 6, S: 4, T: 6,
    U: 4, V: 2, W: 2, X: 1, Y: 2, Z: 1
  }
  tile_array = []
  all_tiles.each do |letter, number|
    number.times do
      tile_array.push(letter.to_s)
    end
  end
  tile_array.sample(10)
end

# Wave 2
# Verifies that input is available for play
def uses_available_letters? input, letters_in_hand
  letters_to_check = letters_in_hand.dup
  input.split(//).each do |letter|
    if (letters_to_check.include? letter.upcase) == false
      return false
    end
    letters_to_check.delete_at(letters_to_check.index(letter.upcase))
  end
  return true
end

# Wave 3
# Calculates score for word submitted handling special cases
def score_word word
  score_hash = {
    A: 1, E: 1, I: 1, O: 1, U: 1, 
    L: 1, N: 1, R: 1, S: 1, T: 1,
    D: 2, G: 2,
    B: 3, C: 3, M: 3, P: 3,
    F: 4, H: 4, V: 4, W: 4, Y: 4,
    K: 5,
    J: 8, X: 8,
    Q: 10, Z: 10
  }
  score_total = 0
  word.length.times do |i|
    letter = word[i].upcase
    score_total += score_hash[letter.to_sym]
  end
  if word.length >= 7 && word.length <= 10
    score_total += 8
  end
  return score_total
end

# Wave 4

def tiebreaker current_word, best_word
  if current_word.length == 10 && best_word.length != 10
    current_word
  elsif current_word.length < best_word.length && best_word.length != 10
    current_word
  else 
    best_word
  end
end

# Calculates the highest score from submitted words
def highest_score_from words
  high_score = 0
  high_word = ""

  words.each do |word|
    if score_word(word) > high_score 
      high_score, high_word = score_word(word), word
    elsif score_word(word) == high_score 
      high_score = score_word(tiebreaker(word, high_word))
      high_word = tiebreaker(word, high_word)
    end
  end

  {:word => high_word, :score => high_score}
end

# Wave 5
# Checks for word to be in dictionary
def is_in_english_dict? input
  return ENGLISH_DICT.include?([input.downcase])
end
