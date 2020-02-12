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

# puts "😎=> control, command, space"

#wave 2
def uses_available_letters?(input, letters_in_hand)
  input_splitted = input.split ""
  selected_letters = []
  input_splitted.each do |letter|
    if letters_in_hand.include? letter
      selected_letters << letter
      letters_in_hand = letters_in_hand - selected_letters
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
  word_splitted = word.upcase.split ""

  total_score = 0
  word_splitted.each do |letter|
    score.each do |value, letters_with_value|
      if letters_with_value.include? letter
        total_score = total_score + value.to_i
      end
    end
  end
  if word_splitted.length > 7 && word_splitted.length < 10
    total_score+=8
  end
  
end


