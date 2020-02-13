# writing a method called draw_letters


# wave 1
# method draw_letters randomly generates 10 letters, stores them in an array,
# returns that array of letters
def draw_letters
  compact_bag = {
    "A": 9,
    "B": 2, 
    "C": 2, 
    "D": 4, 
    "E": 12, 
    "F": 2, 
    "G": 3, 
    "H": 2, 
    "I": 9,
    "J": 1, 
    "K": 1, 
    "L": 4,
    "M": 2,
    "N": 6,
    "O": 8,
    "P": 2, 
    "Q": 1, 
    "R": 6,
    "S": 4, 
    "T": 6,
    "U": 4,
    "V": 2,
    "W": 2,
    "X": 1, 
    "Y": 2, 
    "Z": 1
    }
    expanded_bag = []
  compact_bag.each do |letters, number|
    number.times do 
      expanded_bag << letters
    end
  end 
  
  random = []
  10.times do 
  x = rand expanded_bag.length
  while random.include? x
    x = rand expanded_bag.length
    end
    random << x
  end
  
  hand = random.map {|number| expanded_bag[number]}

end


#wave 2
# method uses_available_letters? takes a string and an array of letters
# to determine if the string can be made from the array of letters
# returns true if string is valid (can be made from array of letters)
# returns false if string is invalid (cannot be made from array of letters)
def uses_available_letters? (input, letters_in_hand)
  input <= letters_in_hand.join
end

#wave 3 
# method score_word takes string of characters 
# and returns an integer representing the number of points 
def score_word(word) #word is a string of characters

score = 0

word.upcase.each_char do |char|
  case char
    when "A", "E", "I", "O", "U", "L", "N", "R", "S", "T"
      score += 1
    when "D", "G"
      score += 2
    when "B", "C", "M", "P"
      score += 3
    when "F", "H", "V", "W", "Y"
      score += 4
    when "K"
      score += 5
    when "J", "X" 
      score += 8
    when "Q", "Z"
      score += 10
    else 
      puts "Invalid char found."
    end
  end



  if [7,8,9,10].include? word.length
    score += 8
  end

  return score

end



# puts uses_available_letters?("cat" ,["c","a","t", "t", "t"])
# puts score_word("belvita")


my_hand = draw_letters 

# Wave 4
# method has one parameter (word)
# returns a hash (winning word, score) the highest scoring word
# if tied using tie-breaking method (when choosing do the followings: prefer word with fewer letters ;
# if multiple words have the same score, choose the one w/fewest letters unless one word has 10 letters, 
# if letters and scores are the same, choose the first one you see)

def highest_score_from(words) # words is going to be array of strings
 all_scores = []
  words.each do |word|
  score = score_word(word)
  all_scores << {:word => word, :score => score}
 end
 #puts all_scores
 highest_score = all_scores.max_by{|word_with_score| word_with_score[:score]}
 p "This is one max score: #{highest_score}"
 
all_highscores = all_scores.select{|word_with_score| word_with_score[:score] == highest_score[:score]}
puts "This is ALL the words that match high score: #{all_highscores}"
  # return {winning_word, score}

  #look in the all_highscores look at the hash and pull the word only 
  words = []
  all_highscores.each do |hash|
    words << hash[:word]
  end

  puts "This is our array of just words: #{words}"
# word = ["hhaannhhnn", "cat"]
# if word length != 10
# then check for smallest word
# if word lenghs are == the same
# choose thes first word

all_tens = words.select{|word| word.length == 10}
# all_tens = ["hhaannhhnn", "hannahnnaa"] here we are gonna select the first 10 letter word
# 1) if all_tens.size > 1 grab the first itm in the array
# 2) if all_tens.size == 1 grab the first time in the array
# 3) if all_tens.empty? then check for smallest word
winning_word = ""
if all_tens.size >= 1 
  winning_word = all_tens[0]
else
  all_smallest = words.min_by{|word| word.length}
  if all_smallest.class == Array 
    winning_word = all_smallest[0]
    else
      winning_word = all_smallest
    end
end

puts "This is our winning word: #{winning_word}"




end



 


 highest_score_from (["sugarmouses", "mousesugars","z"])
# (["cat", "hannah", "cheezit", "itcheez"])













#  letters = []
#  10.times do 
#  letter_pool
#  end

# end