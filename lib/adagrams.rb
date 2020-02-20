# Wave 1 method: drawing 10 letters into hand
def draw_letters 
    letter_quantities = {
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

    letter_pool = []
    letter_quantities.each do |letter, num|
        num.times do
            letter_pool << letter
        end
    end

    return letter_pool.shuffle[0..9]
end

# Wave 2: Checks that input uses letters that are in hand
def uses_available_letters?(input, letters_in_hand)
    input_array = input.upcase.split(//)
    input_array.each do |letter|
        if input_array.count(letter) > letters_in_hand.count(letter) 
            return false
        end
    end
    return true
end

# Wave 3: return a score for input word
def score_word(word)
    letter_values = {
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
    total_score = 0
    word.upcase.split(//).each do |letter|
        total_score += letter_values[letter]
    end

    if word.length > 6
        total_score += 8
    end

    return total_score    
end

# Wave 4: Outputs winning word and score
def highest_score_from(words)
    highest_score = 0
    winning_words = []
    words.each do |word|
        if score_word(word) > highest_score
            highest_score = score_word(word)
            winning_words.clear << word
        elsif score_word(word) == highest_score
            winning_words << word
        end
    end

    # no tie scenario
    if winning_words.count == 1
        return {word: winning_words[0], score: highest_score}
    else 

        # tie scenario
        winning_words.each do |word|
            # determines whether word is 10 letters long
            if word.length == 10
                return {word: word, score: highest_score}
            end
        end
        # if there is no 10 letter word, find shortest word
        winner = winning_words.min_by do |word|
            word.length
        end 

        return {word: winner, score: highest_score}
    end    
end

# Wave 5: check if input is an english word
def is_in_english_dict?(input)
    file = File.open("assets/dictionary-english.csv", "r")
    dictionary = file.collect(&:chomp)
    file.close
    return dictionary.include?(input.downcase)
end