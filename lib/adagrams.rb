require 'csv'

def draw_letters
  pool = {
    "a" => 9,
    "b" => 2,
    "c" => 2,
    "d" => 4,
    "e" => 12,
    "f" => 2,
    "g" => 3,
    "h" => 2,
    "i" => 9,
    "j" => 1,
    "k" => 1,
    "l" => 4,
    "m" => 2,
    "n" => 6,
    "o" => 8,
    "p" => 2,
    "q" => 1,
    "r" => 6,
    "s" => 4,
    "t" => 6,
    "u" => 4,
    "v" => 2,
    "w" => 2,
    "x" => 1,
    "y" => 2,
    "z" => 1
  }
  user_letters = []
  10.times do
    letter = pool.keys.sample(1)
    letter = letter[0].to_s
    user_letters << letter
    pool[letter] -= 1
    if pool[letter] == 0
      pool.delete(letter)
    end
  end
  return user_letters
end

def uses_available_letters?(input, letters_in_hand)
  input_letters = input.split(//).sort
  user_letters = letters_in_hand.clone
  input_letters.each do |letter|
    if user_letters.include?(letter)
      user_letters.delete(letter)
    else
      return false
    end
  end
  return true
end


def score_word(word)
  letter_points = {
    "A" => 1,
    "E" => 1,
    "I" => 1,
    "O" => 1,
    "U" => 1,
    "L" => 1,
    "N" => 1,
    "R" => 1,
    "S" => 1,
    "T" => 1,
    "D" => 2,
    "G" => 2,
    "B" => 3,
    "C" => 3,
    "M" => 3,
    "P" => 3,
    "F" => 4,
    "H" => 4,
    "V" => 4,
    "W" => 4,
    "Y" => 4,
    "K" => 5,
    "J" => 8,
    "X" => 8,
    "Q" => 10,
    "Z" => 10
  }
  score = []
  letters = word.upcase.split(//)
  letters.each do |letter|
    score << letter_points[letter]
  end
  if letters.length > 6
    score << 8
  end
  return score.sum
end

# The required parameters of the method 'tiebreaker' is the array 'winning_words' and the hash 'results'.
def tiebreaker(winning_words, results)
  winner = {}
# Finding the shortest word in the array 'winning_words' and assigning it to the variable 'shortest_word'.
  shortest_word = winning_words.min_by{|word| word.length}
  winning_words.each do |word|
# Checking whether or not there is a word that is 10 letters by iterating through 'winning_words'. If so, that word is immediately returned as the winner.
    if word.length > 9
      winner[:word] = word
      winner[:score] = results[winning_words[0]]
      return winner
    end
  end
# If no word is 10 letters, the array 'winning_words' is iterated through a second time and the word matching the shortest length is return as the winner.
  winning_words.each do |word|
    if word.length == shortest_word.length
      winner[:word] = word
      winner[:score] = results[winning_words[0]]
      return winner
    end
  end
end

def highest_score_from(words)
  results = {}
  scores = []
  winner = {}
  words.each do |word|
    score = score_word(word)
    results[word] = score
  end
# Finding the highest scored word from the hash 'results' and assigning it to the value 'highest score'.
  highest_score = results.max_by{|word, score| score}
  winning_words = []
  words.each do |word|
# Iterating through the array 'words' and shoveling all words with a score matching the highest score to the array 'winning_words'.
    if results["#{word}"] == highest_score[1]
      winning_words << word
    end
  end
# If the length of the array 'winning_words' is greater than 2, the method 'tiebreaker' is invoked.
  if winning_words.length > 1
      winner = tiebreaker(winning_words, results)
      return winner
  else
# If there is only 1 winning word, the word and it's score is created as a key-value pair in the hash 'winner' and returned to the user.
    winner[:word] = winning_words[0]
    winner[:score] = results[winning_words[0]]
    return winner
  end
end

def is_in_english_dict?(input)
  file = File.open("assets/dictionary-english.csv")
  dictionary = file.readlines.map(&:chomp)
  if dictionary.include?(input.downcase)
    return true
  else
    return false
  end
end