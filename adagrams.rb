# Yesenia Torres + Quin Quintero 
# adagrams.rb 

# Gems
require "minitest"
require  'pry'
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
        # puts letter_pool
        # Create hand array
        hand = random_hash.map do |letter, quantity|
            letter.to_s
        end
    binding.pry
    return hand
end 


# Check anagram uses letters from the drawn hand 
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
def highest_score_from(words, score_word = :score_word)
    
    highest_hash = {}

    # create a hash of the words and their scores 
    words.each do |word| 
        highest_hash.merge!("#{word}": score_word(word.upcase))  
    end

    # ------------------------------------------------ our attempt to integrate logic, not currently working

    shortest_word_length = words[0].length 
    highest_scored_word = ""
    highest_score = 0
    
    # we want to be able to iterate through esach of the tied highest words and pull out the winner of the tie
    highest_hash.each do |word, score|
        #will return word if greater than 10 automatically 
        if word.to_s.length == 10
            highest_scored_word = word.to_s
            highest_score = score
            break
        else 
            if word.to_s.length <= shortest_word_length 
                
                highest_scored_word = word.to_s
                highest_score = score 
            end 
            
        end 
    end 
    return {highest_scored_word => highest_score}
end

#uts uses_available_letters?("x", ["y", "e", "s"])
puts draw_letters.to_s
