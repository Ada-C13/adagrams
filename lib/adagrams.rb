
def draw_letters
  big_pool_of_letters = {
    "A" => 9,
    "B" => 2,
    "C" => 2,
    "D" => 4,
    "E" => 12,
    "F" => 2,
    "G" => 3,
    "H" => 2,
    "I" => 9,
    "J" => 1,
    "K" => 1,
    "L" => 4,
    "M" => 2,
    "N" => 6,
    "O" => 8,
    "P" => 2,
    "Q" => 1,
    "R" => 6,
    "S" => 4,
    "T" => 6,
    "U" => 4,
    "V" => 2,
    "W" => 2,
    "X" => 2,
    "Z" => 1
  }

  user_letters = []

  while user_letters.length < 10

    letters = big_pool_of_letters.keys
    rand_letter = big_pool_of_letters.keys[rand(letters.size)]

    if big_pool_of_letters[rand_letter] != 0
      user_letters << rand_letter
      big_pool_of_letters[rand_letter] -= 1
    end
  end

  return user_letters
end

def uses_available_letters?(input, letters_in_hand)
  input.upcase!
  unused_letters = letters_in_hand[0..-1]
  
  input.each_char do |letter|
    if unused_letters.include?(letter)
      unused_letters.delete_at(unused_letters.index(letter))
    else
      return false
    end
  end
  return true
end


def score_word(word)
  word.upcase!
  if word.length == 0
    return 0
  elsif word.length >= 7
    extra_points = 8
  else
    extra_points = 0
  end

  split_word = word.split("")
  points = split_word.map do |letter|
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
    end
  end
  return points.sum + extra_points
end

def highest_score_from(words)
  highest_score = 0
  highest_score_word = ""

  words.each do |word|
    score_of_word = score_word(word)
    if score_of_word > highest_score
      highest_score = score_of_word
      highest_score_word = word
    elsif score_of_word == highest_score
      if word.length == highest_score_word.length && word.length == 10 
      elsif word.length == 10 
        highest_score_word = word
        highest_score = score_of_word
      elsif word.length < highest_score_word.length && highest_score_word.length != 10
        highest_score_word = word
        highest_score = score_of_word
      end
    end
  end
 return {word: highest_score_word, score: highest_score}
end

uses_available_letters?("aei", ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"])
# letters_in_hand = draw_letters
# p "This are the letters in your hand: #{letters_in_hand}."

# p "Thell as a word from the provided letters?"
# input = gets.chomp.upcase

# highest_score_from(words)
# p score_word(input)

