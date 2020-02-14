require "csv"
require "awesome_print"

$LETTERS = {
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
  "X" => 1,
  "Y" => 2,
  "Z" => 1
}

# Wave 1
def draw_letters
  pool = []
  $LETTERS.map do |letter, tiles|
    tiles.times do 
      pool << letter
    end
  end
  pool = pool.shuffle.drop(88)
  return pool
end

# Wave 2
def uses_available_letters?(input, letters_in_hand)
  input_array = Array.new(input.chars)
  current_hand = Array.new(letters_in_hand)
  input_array.map do |letter|
    puts "The letter is #{letter}"
    if current_hand.index(letter) != nil
      puts "Found the letter!"
      puts "Here is the index: #{current_hand.index(letter)}"
      current_hand.delete_at(current_hand.index(letter))
      puts "Here is the array now: #{current_hand}"
    else
      return false
    end
  end
  return true
end

# Wave 3
$LETTER_VALUES = {
  "A" => 1,	
  "B" => 3,	
  "C" => 3,	
  "D" => 2,	
  "E" => 1,	
  "F" => 4,
  "G" => 2,	
  "H" => 4,	
  "I" => 1,	
  "J" => 8,	
  "K" => 5,	
  "L" => 1,	
  "M" => 3,	
  "N" => 1,
  "O" => 1,
  "P" => 3,
  "Q" => 10,
  "R" => 1,
  "S" => 1,
  "T" => 1,
  "U" => 1,
  "V" => 4,
  "W" => 4,
  "X" => 8,
  "Y" => 4,
  "Z" => 10
}

def score_word(word)
  total_points = 0
  word_array = Array.new(word.upcase.chars)
  points = word_array.map do |char|
    $LETTER_VALUES.fetch_values(char)
  end
  total_points = points.flatten.sum
  total_points += 8 if word_array.length >= 7
  return total_points
end

# Wave 4
def highest_score_from(words)
  all_words = []
  max_score = 0

  words.each do |word|
    word_data = {}
    word_data[:word] = word
    word_data[:score] = score_word(word)
    all_words << word_data
  end

  tie_score = []
  all_words.each do |hash|
    current_score = hash[:score]
    if current_score > max_score
      max_score = current_score
      tie_score = [hash]
      tie_score << hash
    elsif current_score == max_score
      tie_score << hash
    end
  end

  smallest = 11
  shortest_words = []

  # if only one element in tie_score, that's the winner
  return tie_score[0] if tie_score.length == 1

  tie_score.each do |tie|
    # if 10 chars long, that's the winner
    if tie[:word].length == 10
      return tie
    # if smaller word is found, update smallest and create a new shortest_words array to collect any possible ties for shortest length
    elsif tie[:word].length < smallest
      smallest = tie[:word].length
      shortest_words = [tie]
      # if more than one word ties for smallest, put it into existing shortest_words array
    elsif tie[:word].length == smallest
      shortest_words << tie
    end
  end
  
  # if winner wasn't already found, the winner is the first item of shortest_words
  return shortest_words[0]
end

# Wave 5
def is_in_english_dict?(input)
  found_word = []
dictionary = CSV.read("../assets/dictionary-english.csv", headers: true).each do |record|
  if record["Word"] == input.downcase
      puts "Your word was found."
      return true
    end
  end
  return false
end