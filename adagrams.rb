# wave 1
def draw_letters
  letters_pool = %w(A A A A A A A A A B B C C D D D D E E E E E E E E E E E E F F G G G H H I I I I I I I I I J K L L L L M M N N N N N N O O O O O O O O P P Q R R R R R R S S S S T T T T T T U U U U V V W W X Y Y Z)
  hand = []

  10.times do
    hand << letters_pool.sample
  end

  return hand
end

# wave 2
def uses_available_letters?(input, letters_in_hand)
  letters = input.upcase.split('')
  is_in_hand = true

  letters.each do |letter|
    if !(letters_in_hand.include?(letter))
      is_in_hand = false
    end
  end

  return is_in_hand
end

# wave 3
def score_word (word)
  letters = word.upcase.split('')
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

  if letters.length >= 7 && letters.length <= 10
    score += 8
  end

  return score
end

#a method that accepts an array of words that have been created, gets the highest score from this array. Pass each word from the array into the scoring method, returns will be inserted into an array, and for the word that is the highest score it will be reserved into a single hash with the word as the key and the score as the value. 

# wave 4
def highest_score_from(words)
  words_hash = {}

  words.each do |word|
    words_hash[word] = score_word(word)
  end


  highest_word = ""
  highest_scored = 0

  words_hash.each do |word, score|
    if score > highest_scored 
      highest_scored = score
      highest_word = word
    elsif score == highest_scored
      #it's a duplicate!
      case word
      when word.length == 10 && highest_word.length != 10
        highest_word = word
      when highest_word.length > word.length
        highest_word = word
      end
    end
    return {word: highest_word, score: highest_scored}
  end
end

drawn_hand = draw_letters

user_word = 'o'

validity = uses_available_letters?(user_word, drawn_hand)

result = highest_score_from(['alicia', 'jessica', 'jared', 'shonda', 'becca'])
puts result

score = 0

if validity == true
  score = score_word (user_word)
end