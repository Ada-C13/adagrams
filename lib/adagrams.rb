def draw_letters
  letters_amount = {
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

  tiles_array = []
  letters_amount.map {|key,value| value.times {|amount| tiles_array << key}} 

 return tiles_array.sample(10)

end

def uses_available_letters?(input, letters_in_hand)
  letters_in_hand_copy = letters_in_hand.dup
  input_array = input.split(//)

  input_array.each do |ind_letter|
    if letters_in_hand_copy.include? (ind_letter)
      letters_in_hand_copy.slice!(letters_in_hand_copy.index(ind_letter))
    else 
      return false
    end
  end 
 
  return true 
end


def score_word(word)
  letters_array = word.split(//)
  word_score = 0

  letters_array.each do |each_letter|
    case each_letter.upcase
      when "A","E","I","O","U","L","N","R","S","T"
        word_score += 1
      when "G","D"
        word_score += 2
      when "B","C","M","P"
        word_score += 3
      when "F","H","V","W","Y"
        word_score += 4
      when "K"
        word_score += 5
      when "J","X"
        word_score += 8
      when "Q","Z"
        word_score += 10
    end

  end

    if letters_array.length > 6
      word_score += 8
    end

    return word_score
end


def highest_score_from(words)
  best_scoring_word = ''
  best_score = 0
  word_value_hash = {}

  words.each do |word|
    word_score = score_word(word) # To note: we used the def score_word that is defined above.

    word_value_hash["#{word}"] = word_score

    if word_score > best_score
      best_score = word_score
      best_scoring_word = word
    end

  end

    tie = []
    max_score = word_value_hash.values.max

    word_value_hash.each do |scored_word,points|
      if points == max_score
        tie << scored_word
      end
    end


  if tie.count > 1
    best_tie_word = ""
    shortest_tie_length = 0

    tie.each do |tie_word|  # evaluates a tie situation to account for words that have 10 letters, and other factors.
      if tie_word.length == 10 && best_tie_word.length != 10
        best_tie_word = tie_word
        shortest_tie_length = 1
      elsif shortest_tie_length == 0
        shortest_tie_length = tie_word.length
        best_tie_word = tie_word
      elsif tie_word.length < shortest_tie_length
        shortest_tie_length = tie_word.length
        best_tie_word = tie_word
      else
        nil
    
      end
    end

    best_scoring_word = best_tie_word
  end

  return {:word => best_scoring_word, :score => best_score} 
end
