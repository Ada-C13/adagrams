# Wave 1

def draw_letters
  pool = {
    A: Array.new(9, "A"),
    B: Array.new(2, "B"),
    C: Array.new(2, "C"),
    D: Array.new(4, "D"),
    E: Array.new(12, "E"),
    F: Array.new(2, "F"),
    G: Array.new(3, "G"),
    H: Array.new(2, "H"),
    I: Array.new(9, "I"),
    J: Array.new(1, "J"),
    K: Array.new(1, "K"),
    L: Array.new(4, "L"),
    M: Array.new(2, "M"),
    N: Array.new(6, "N"),
    O: Array.new(8, "O"),
    P: Array.new(2, "P"),
    Q: Array.new(1, "Q"),
    R: Array.new(6, "R"),
    S: Array.new(4, "S"),
    T: Array.new(6, "T"),
    U: Array.new(4, "U"),
    V: Array.new(2, "V"),
    W: Array.new(2, "W"),
    X: Array.new(1, "X"),
    Y: Array.new(2, "Y"),
    Z: Array.new(1, "Z")
  }

  pool_values = pool.map do |key, value|
    value
  end

  pool_final = pool_values.flat_map do |letter|
    letter
  end

  user_took = []

  10.times do |i|
    pool_final.shuffle!
    user_took << pool_final.slice!(0)
  end

  return user_took
end 

user_1 = draw_letters
user_2 = draw_letters

p user_1
p user_2


# p pool_final.length
# p user_took 
# p pool_final.sort


# Wave 2.
def uses_available_letters?(input, letters_in_hand)
  input = input.split("")

  letters_in_hand.each do |letter|
    if input.index(letter)
      input.slice!(input.index(letter))
    end
  end

  return input.empty?
end

# Wave 3 
def score_word(word)

  word = word.upcase

  score_table = {
    "1" =>  %w[A E I O U L N R S T],
    "2" => %w[D G],
    "3" => %w[B C M P],
    "4" => %w[F H V W Y],
    "5" => %w[K],
    "8" => %w[J X],
    "10" => %w[Q Z]
  }

  if word == ""
    return 0
  end

  word_array = word.split("")
  word_score = []

  word_array.each do |char|
    score_table.each do |key,value|
      if value.include?(char)
        word_score << key.to_i
      end
    end 
  end 

  calculated_points = word_score.reduce(:+)

  if word_array.length >= 7 
    calculated_points += 8 
  end 

  return calculated_points
end 

# Wave 4:

# def highest_score_from(words)
# end

# words = ["CAT", "CD", "AA"]

# word_score_list = []

# words.each do |word|
#   word_score_list << score_word(word)
# end

# winner_index = []

# word_score_list.each_with_index do |score, index|
#   if word_score_list.max == score
#     winner_index << index
#   end
# end

# winning_word = {}

# if winner_index.length > 1

#   winner_index.each do |index_location|
#     if words[index_location].length == 10
#       winning_word[:word] = words[index_location]
#       winning_word[:score] = word_score_list[index_location]
#     end 
#   end 

  
# end 



# p winner_index


# p word_score_list

# p word_score_list.max

# p word_score_list.index(word_score_list.max)



# ############

# # words = ["CAT", "MOUSE", "MICE"]

# # words_with_scores = []
# # words.each do |word|
# #   current_word = {}
# #   current_word[:word] = word
# #   current_word[:score] = score_word(word)
# #   words_with_scores << current_word
# # end

# # p words_with_scores



