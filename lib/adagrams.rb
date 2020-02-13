require 'csv'

LETTER_QUANTITIES = {
  'A': 9,
  'B': 2,
  'C': 2,
  'D': 4,
  'E': 12,
  'F': 2,
  'G': 3,
  'H': 2, 
  'I': 9,
  'J': 1,
  'K': 1,
  'L': 4,
  'M': 2,
  'N': 6,
  'O': 8,
  'P': 2,
  'Q': 1,
  'R': 6,
  'S': 4,
  'T': 6,
  'U': 4,
  'V': 2,
  'W': 2,
  'X': 1,
  'Y': 2,
  'Z': 1
}

# method to generate 10 random letters 
def draw_letters
  pool_of_letters = [] 
  # loop over LETTER_QUANTITIES hash to add the right quantity of each letter to the pool
  LETTER_QUANTITIES.each do |letter, quantities|
    quantities.times do 
      pool_of_letters.push(letter.to_s)
    end
  end 

  chosen_letters = [] 
  # create an array of 10 random numbers to be used as indexes in the pool array 
  random_indexes_array = (0...pool_of_letters.length).to_a.sample(10)

  # loop through the array of indexes and add the indexed element to chosen_letters
  random_indexes_array.each do |index|
    chosen_letters.push(pool_of_letters[index])
  end

  return chosen_letters
end

# method to determine if the letters in the user input are in the array of chosen letters
def uses_available_letters?(input, chosen_letters)
  # create a clone of the chosen_letters array so the original does not get altered
  chosen_letters_array_to_manipulate = chosen_letters.clone  
  input_split_letters = input.upcase.split("")
  
  # loop through each letter of user input and check if it's in the chosen_letters array
  input_split_letters.each do |letter|
    if chosen_letters_array_to_manipulate.include?(letter)
      chosen_letters_array_to_manipulate.delete_at(chosen_letters_array_to_manipulate.index(letter))
    else
      return false
    end
  end

  return true
end

# method to calculate the score of a word
def score_word(word)
  letter_values = {
    ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"] => 1,
    ["D", "G"] => 2,
    ["B", "C", "M", "P"] => 3,
    ["F", "H", "V", "W", "Y"] => 4,
    ["K"] => 5,
    ["J", "X"] => 8,
    ["Q", "Z"] => 10
  }
  letters_in_word = word.upcase.split("")
  total = 0
 
  # for each letter, loop through the values hash and add the value of each letter to the total
  letters_in_word.each do |letter|
    letter_values.each do |letter_array, value|
      if letter_array.include?(letter)
        total += value
      end    
    end
  end

  if word.length > 6
    total += 8
  end

  return total
end

# method to determine which word has the highest score
def highest_score_from(words)
  word_with_highest_score = ""
  highest_score = 0
 
  words.each do |word|
    score_of_word = score_word(word)
    if score_of_word > highest_score
      word_with_highest_score = word
      highest_score = score_of_word
    elsif score_of_word == highest_score
      if word.length == 10 && word_with_highest_score.length != 10
        word_with_highest_score = word
        highest_score = score_of_word
      elsif word.length < word_with_highest_score.length && word_with_highest_score.length != 10
        word_with_highest_score = word
        highest_score = score_of_word
      end  
    end
  end

  return {:word => word_with_highest_score, :score => highest_score}
end

# method to determine if word is in the english dictionary
def is_in_english_dict?(input)
  csv_data = CSV.parse(File.read("assets/dictionary-english.csv"), headers: true).by_col[0]
  return csv_data.include?(input.downcase)
end
