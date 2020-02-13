require 'csv'

# Added feature for Wave 1 here:
def draw_letters
  letter_pool = {
    A: 9, B: 2, C: 2, D: 4, E: 12, F: 2, G: 3, H: 2, I: 9, J: 1,K: 1, L: 4, M: 2, N: 6, O: 8, P: 2, Q: 1, R: 6, S: 4, T: 6, U: 4, V: 2, W: 2, X: 1, Y: 2, Z: 1 
  }

  hand = []
  letter_pool.each do |letter, quantity|
    quantity.times do |i|
      hand << letter.to_s
    end
  end

  return hand.sample(10)
end


# Added feature for Wave 2 here:
def uses_available_letters?(input, letters_in_hand)

  # edge case
  return false if input.length > 10 || input.length < 1 

  temp_in_hand = letters_in_hand.clone

  input.upcase!
  tile_split = input.split("")

  tile_split.each do |letter, i|
    return false if !temp_in_hand.include?(letter)   

    # Delete a letter that was used from <temp_in_hand>
    temp_in_hand.delete(letter) 
  end 
  return true
end


# Added feature for Wave 3 here:
def score_word(word) 
  points = {
    ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"] => 1,
    ["D", "G"] => 2,
    ["B", "C", "M", "P"] => 3,
    ["F", "H", "V", "W", "Y"] => 4,
    ["K"] => 5,
    ["J", "X"] => 8,
    ["Q", "Z"] => 10
  }

  score = 0 
  score += 8 if (word.length > 6) && (word.length < 11) 

  tile_split = word.upcase.split("")

  tile_split.each do |letter| 
    points.each do |score_chart, point|
      score += point if score_chart.include?(letter) 
    end 
  end    
  return score
end


# Added feature for Wave 4 here:
def highest_score_from(words)
  contestants = words.map{ |word| [word, score_word(word)] }.to_h

  winning_word = {word: "", score: 0}

  contestants.each do |word, score|
    if score > winning_word[:score]
      winning_word = {word: word, score: score}
    elsif score == winning_word[:score] 
      if winning_word[:word].length == 10
        next
      elsif word.length == 10
        winning_word = {word: word, score: score}
      elsif word.length < winning_word[:word].length
        winning_word = {word: word, score: score}
      end
    end  
  end
  return winning_word
end 


# Added feature for Wave 5 here:
def is_in_english_dict?(input)
  input.downcase! 

  dictionary = CSV.read("assets/dictionary-english.csv")
  dictionary = dictionary.flatten

  dictionary.include?(input) ? true : false
end 