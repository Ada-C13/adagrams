# hash of available letters to pull from
$letters = {
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

# hash chart of each letter with their score value
$score_chart = {
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

# method to draw 10 letters
def draw_letters
  ten_letters = []
  letters = $letters.keys 
# this loop pulls random letters from hash and pushes it into an array
  10.times do |index|
     rand_letter = letters[rand(letters.size)]
      if $letters[rand_letter] == 0
        rand_letter = letters[rand(letters.size)]
      else
        $letters[rand_letter] -= 1 
      end
    ten_letters << rand_letter
  end  
    return ten_letters
end


# takes in the letters and verifies of the letters used are in the current hand
def uses_available_letters?(input, letters_in_hand)
  input = input.split("")
  in_hand_dup = letters_in_hand.dup

  input.each do |x|
    unless in_hand_dup.include? x 
     return false
    end
    in_hand_dup.delete(x)
  end
  return true
end

# method that calculates the tiles being played and returns the total score
def score_word(word)
  total_score = 0
  if word.empty? 
    return total_score 
  else
    user_word = word.upcase.split("")
    total_score = user_word.inject(0) {|sum, word| sum + $score_chart[word]}
    if user_word.length == 7 || user_word.length == 8 || user_word.length == 9 || user_word.length == 10
      total_score += 8
    end
  end
  return total_score
end

# method that takes the word with the highest score the total score
def highest_score_from(words)
  word_score_list = {}
   words.each do |word|
     score = score_word(word)
     word_score_list[word] = score
   end
 
   # method that finds the winning word and it's score
   max_score = 0
   max_word = ""
   i = 0
   while i < words.length 
     # we want to acces the right word inside the hash. 
     # so we acessed the key from the hash and the index value from an array.
     val = word_score_list[words[i]]
       if val > max_score
         max_score = val
         max_word = words[i]
       elsif val == max_score
         # in case of tied score and same length words, prefers the first word
         if words[i].length == max_word.length 
           return {word: max_word, score: max_score}
         elsif words[i].length == 10 
           max_word = words[i]
         # picks the shortest word if there no word that equal to 10 letters long
         elsif words[i].length < max_word.length && max_word.length != 10
           max_word = words[i]
         end
       end
     i += 1
   end
   return {word: max_word, score: max_score}
 end

