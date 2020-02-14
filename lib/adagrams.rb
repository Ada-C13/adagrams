require 'csv'

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
  letters = (input.upcase.split(''))
    # copy_hand = letters_in_hand.

    # copy_hand.each_with_index do |copy_letter, index|
    #   letters.each do |letter|
    #     if copy_letter == letter
    #       copy_hand.delete_at(index)
    #     end
    #   end
    # end
    # if (letters_in_hand.length - copy_hand.length) == letters.length
    #   return true
    # else  
    #   return false
    # end
  check_overlap = letters_in_hand & letters
  check_overlap.sort == letters.sort ? true : false
end

puts uses_available_letters?("agar", ['A', 'B', 'A', 'F', 'R', 'G'])
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
        score += score_value.to_i if letter_array.include?(letter)
    end
  end
  # If the chosen word is greater in length than 7 but less than 10,
  # 8 more points will be added to their score.
  score += 8 if (letters.length >= 7 && letters.length <= 10)

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
    if score > highest_scored
      highest_scored = score
      highest_word = word
    # In case of a tie
    elsif score == highest_scored
      highest_word = tiebreaker(highest_word, word)
    end
  end
  return {word: highest_word, score: highest_scored}
end

# Breaks the tie.
def tiebreaker(highest_word, word)
  case
    when word.length == 10 && highest_word.length != 10
      highest_word = word
    when highest_word.length == 10 && word.length != 10
      highest_word
    when word.length == 10 && highest_word.length == 10
      highest_word
    when word.length < highest_word.length
      highest_word = word
  end
  return highest_word
end

# Wave 5
# Checks if input is a valid word in the English Dictionary.
def is_in_english_dict?(input)
  dictionary = File.open('assets/dictionary-english.csv').readlines.map(&:chomp)
  dictionary.include?(input) ? true : false
end