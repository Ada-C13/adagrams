#WAVE 1
def draw_letters 
  all_letters = { A: 9, B: 2, C: 2, D: 4, E: 12, F: 2, G: 3, H: 2, I: 9, J: 1, K: 1, L: 4, M: 2, N: 6, O: 8, P: 2, Q: 1, R: 6, S: 4, T: 6, U: 4, V: 2, W: 2 , X: 1, Y: 2, Z: 1}
  
  letter_pool = [] 
  all_letters.each do |letter,count|
    letter_pool.concat(Array.new(count) { letter.to_s })
  end  
  hand_letters = letter_pool.sample(10)
  return hand_letters
end 

#WAVE 2 
def uses_available_letters?(input, letters_in_hand)
  letter_bank = letters_in_hand.dup 
  
  input.split(//).each do |l|
    if letter_bank.include?(l)
      letter_bank.delete_at(letter_bank.index(l))
    else 
      return false 
    end 
  end 
  return true 
end 

#WAVE 3 
def score_word(word)

 letters = word.upcase.split(//)
  score_pool = {["A", "E", "I", "O", "U", "L"," N", "R", "S", "T"]=> 1,["D", "G"] => 2, ["B", "C", "M", "P"] => 3,["F", "H", "V", "W", "Y"]=> 4, ["K"] => 5, ["J", "X"] => 8, ["Q", "Z"] => 10}

  score = 0

  letters.each do |l|
    score_pool.each do |array, points|
      if array.include?(l)
        score += points
      end 
    end 
  end 
  if letters.size >=7 && letters.size <=10
    score += 8
  end
  return score
end

#WAVE 4
def highest_score_from(arr)
  word_score ={}
  arr.each do |item|
    word_score[item] = score_word(item)
  end
  sorted_hash = word_score.sort_by{|k, v| -v}.to_h
  
  highest_score = sorted_hash.values.max
  sorted_hash.delete_if{|k,v| v != highest_score}
  if sorted_hash.size > 1
    if sorted_hash.any? {|key, value| key.length == 10 }
      sorted_hash.delete_if { |k,v| k.length != 10 }
      sorted_hash.delete_if { |k,v| k != sorted_hash.keys[0] }
    elsif
      shortest_hash = sorted_hash.keys.sort_by {|k, v| k.length}
      shortest_word = shortest_hash[0]
      score_of_winningword = sorted_hash.values_at(shortest_hash)
      sorted_hash.delete_if { |k,v| k != shortest_word }
    end 
  end
    winning_score = {}   
    winning_score[:word] = sorted_hash.keys[0]
    winning_score[:score]  = sorted_hash.values[0]
    return winning_score
end

#WAVE 5
def is_in_english_dict?(input)
  word = false
  CSV.foreach("../assets/dictionary-english.csv") do |record|
    if record.include?(input.downcase)
      word = true
    end
  end
  return word 
end






