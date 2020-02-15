#make the data structure for all the letters and the number of letters availble
#wave 1:)

def draw_letters
  sample = {
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
    "z" => 1,
  }
  #create an array with all the availble letters
  pool_letters = []
  sample.each do |letter, quantity|
    quantity.times do
      pool_letters << letter
    end
  end

  #randomize the pool of letters
  pool_letters = pool_letters.sample(pool_letters.length)

  #display the 10 letters they have drawn
  return pool_letters.first(10)
end

#wave 2
def uses_available_letters?(input, letters_in_hand)
  input_splitted = input.split ""
  #make a copy of letters in hand so it remains un-changed
  #[].replace will replace the contents of selected_letters array which is empty with the contents from letters_in_hand
  selected_letters = [].replace(letters_in_hand)
  input_splitted.each do |letter|
    if selected_letters.include? letter
      where_is_my_letter = selected_letters.find_index(letter) #using .find_index to see where that letter from the word is in the array that contain the 10 availble letters
      selected_letters.delete_at(where_is_my_letter) #modify the duplicated array (selected_letters) to remove that item from the array, this will ensure that only the letter with that index is removed instead of all the same-letters in the hand
    else
      return false
    end
  end
  return true
end

#wave 3
def score_word(word)
  score = {
    "1" => %w(A E I O U L N R S T),
    "2" => %w(D G),
    "3" => %w(B C M P),
    "4" => %w(F H V W Y),
    "5" => %w(K),
    "8" => %w(J X),
    "10" => %w(Q Z),
  }
  #converting the word into upcase so it would be independent of the users input
  word_splitted = word.upcase.split ""
  total_score = 0
  word_splitted.each do |letter|
    score.each do |value, letters_with_value|
      total_score += value.to_i if letters_with_value.include? letter #add the associated value  with that letter (converted to integer) to the total score
    end
  end
  if word_splitted.length >= 7 && word_splitted.length <= 10
    total_score += 8
  end
  return total_score
end

#wave 4
def highest_score_from(words)
  word_and_score = {}
  words.each do |word|
    word_and_score[word] = score_word(word) #calling the method score_word to determine the score of that word
  end

  highest_score = 0
  highest_scored_name = nil
  word_and_score.each do |word, score|
    if score > highest_score #determine the word with the highest score
      highest_score = score
      highest_scored_name = word
    end

    if highest_score == score #in case there is a tie of scores
      if highest_scored_name.length < 10 && word.length < 10 && highest_scored_name.length > word.length #if the length of the word is less than 10 letters, the word with the least letters will win
        highest_scored_name = word
      elsif (highest_scored_name.length >= 10 || word.length >= 10) && word.length > highest_scored_name.length #unless a word is 10 letters or longer, the that word will be the winner
        highest_scored_name = word
      end
    end
  end
  winning_word_score = {
    word: highest_scored_name,
    score: highest_score
  }
  return winning_word_score
end

#wave 5
require "csv"

#requiring the English dictionary that is in a CSV file to see if the user's input is an actual English word
def is_in_english_dict?(input)
  words = CSV.read("./assets/dictionary-english.csv")
  words.each do |word|
    if word.include? input
      return true
    end
  end
  return false
end
