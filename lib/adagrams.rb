# Wave 1
# Draws ten letters for the user.
def draw_letters
  # Variable holding our pool of letters.
  letters_pool = %w(A A A A A A A A A B B C C D D D D E E E E E E E E E E E E F F G G G H H I I I I I I I I I J K L L L L M M N N N N N N O O O O O O O O P P Q R R R R R R S S S S T T T T T T U U U U V V W W X Y Y Z)
  # Variable holding the letters passed to the user.
  hand = []

  10.times do
    hand << letters_pool.sample
  end
  return hand
end

# Wave 2
# Checks if the word the user inputs is available in letters in hand.
def uses_available_letters?(input, letters_in_hand)
  # Variable holding array of letters of chosen word.
  letters = input.upcase.split('')
  check_overlap = letters_in_hand & letters
  check_overlap == letters ? true : false
end

# Wave 3
# Scores the word that the user has inputted.
def score_word(word)
  # Variable holding individual letters of chosen word.
  letters = word.upcase.split('')
  # Variable tracking the score of the word.
  score = 0

  score_table = {
    1 => ['A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T'],
    2 => ['D', 'G'],
    3 => ['B', 'C', 'M', 'P'],
    4 => ['F', 'H', 'V', 'W', 'Y'],
    5 => ['K'],
    8 => ['J', 'X'],
    10 => ['Q', 'Z']
  }

  letters.each do |letter|
    score_table.each do |score_value, letter_array|
      if letter_array.include?(letter)
        score += score_value.to_i
      end
    end
  end
  # If the chosen word is greater in length than 7 but less than 10,
  # 8 more points will be added to their score.
  if letters.length >= 7 && letters.length <= 10
    score += 8
  end
  return score
end

# Wave 4
# Chooses the highest scoring word from all words inputted.
def highest_score_from(words)
  # Variable tracking each word and its respective score.
  words_hash = {}
  highest_word = "" # Variable tracking word that scores the highest.
  highest_scored = 0 # Variable tracking the highest score.

  words.each do |word|
    words_hash[word] = score_word(word)
  end

  words_hash.each do |word, score|
    case
      when score > highest_scored
        highest_scored = score
        highest_word = word
      # In case of a tie
      when score == highest_scored && word.length == 10 && highest_word.length != 10
        highest_word = word
      when score == highest_scored && highest_word.length == 10 && word.length != 10
        highest_word
      when score == highest_scored && word.length == 10 && highest_word.length == 10
        highest_word
      when score == highest_scored && word.length < highest_word.length
        highest_word = word
    end
  end
  return {word: highest_word, score: highest_scored}
end