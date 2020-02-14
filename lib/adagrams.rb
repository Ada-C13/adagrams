# Yesenia Torres + Quin Quintero 
# adagrams.rb 

require "minitest"
# require "minitest-reporters"
# require "minitest-skip"

# WAVE 1

def draw_letters 
  letter_pool = {
        #letter => quantity 
    :A => 9, :B => 2,:C => 2, :D => 4,:E => 12,:F => 2,
    :G => 3,:H => 2,:I => 9,:J => 1,:K => 1,:L => 4,:M => 2,:N => 6,
    :O => 8,:P => 2,:Q => 1,:R => 6,:S => 4,:T => 6,:U => 4,:V => 2,
    :W => 2, :X => 1,:Y => 2,:Z => 1
    }

    # Create a hand
  random_hash =  letter_pool.to_a.sample(10).to_h
    # puts random_hash
    # Subtract letter that has been used from the letter pool
  random_hash.each do |key, value|
    if random_hash[key] == letter_pool[key] && letter_pool[key] > 1
        letter_pool[key] = value - 1
    else
        letter_pool.delete(key)
    end
    end
    
    # Create hand array
  hand = random_hash.map do |letter, quantity|
      letter.to_s
  end
   
  return hand
end 

# WAVE 2

# Check user input is using the letters from the drawn hand 
def uses_available_letters?(input, letters_in_hand)
  available_letters = letters_in_hand.sort.join.upcase
    
  user_input = input.split("").sort.join.upcase

  return available_letters.include? user_input 
end 

# WAVE 3 

# Calculate score
def score_word(word)
  score = 0 
  upcased_word = word.upcase
  array = upcased_word.split("")
    
    # Add bonus points 
  if word.length >= 7 && word.length <=10
    score += 8
  end 

    # Update score depending on letters used 
  array.each do |letter|
    if ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"].include? letter
        score +=1
    elsif ["D", "G"].include? letter
        score += 2
    elsif ["B", "C", "M", "P"].include? letter
        score += 3
    elsif ["F", "H", "V", "W", "Y"].include? letter
        score +=4
    elsif ["K"].include? letter
        score += 5
    elsif ["J", "X"].include? letter
        score += 8
    elsif ["Q", "Z"]. include? letter
        score += 10 
    else 
        score += 0
    end 
  end 

  return score
end 

# WAVE 4 

# Return highest score
def highest_score_from(words)
    # Create a hash of the words and their scores results 
  score_results = {}
  words.each do |word|  
    score_results[word] = score_word(word.upcase) 
  end
    
    # Find highest score in score_results 
  highest_pair = score_results.max_by {|key, value| value}
  highest_score = highest_pair[1]
    
    # Collect a hash of the tied highest words 
  tied_highest_words = score_results.select {|key, value|  value == highest_score}
    
    # If there is no tie for the highest word, return the winning word/score pair
  winner = ""
  if tied_highest_words.to_a.length == 1
    winner = tied_highest_words
    return {:word => tied_highest_words.keys[0], :score => highest_score} # return final result in appropriate format 
  end 

    # If there is a tie, apply logic to find the tie breaker 
  tie_breaker = tied_highest_words.keys
  tie_winner = tie_breaker.first # intentionally use .first so that if multiple words are the same score and the same length, the first one in the supplied list is chosen
  tie_breaker.each do |word|
        # A word with length 10 automatically wins the tie
  if word.length == 10 
    tie_winner = word
    return {:word => tie_winner, :score => highest_score}
        # Or the shortest length word wins the tie 
  elsif word.length < tie_winner.length
    tie_winner = word
    end
  end 

  return {:word => tie_winner, :score => highest_score}
end