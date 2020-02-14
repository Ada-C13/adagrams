require 'csv'
$letters = {
  A: 9,
  B: 2,
  C: 2,
  D: 4,
  E: 12,
  F: 2,
  G: 3,
  H: 2,
  I: 9,
  J: 1,
  K: 1,
  L: 4,
  M: 2,
  N: 6,
  O: 8,
  P: 2,
  Q: 1,
  R: 6,
  S: 4,
  T: 6,
  U: 4,
  V: 2,
  W: 2,
  X: 1,
  Y: 2,
  Z: 1
}

def draw_letters
 hand = Array.new(10)
  all_letters = $letters.keys
  hand.length.times do |i|
    x = rand(0..$letters.keys.length - 1)
    letter = all_letters[x]
    while hand.count(letter) >= $letters[letter]
      x = rand(0..$letters.keys.length - 1)
      letter = all_letters[x]
    end
    hand[i] = letter
  end
  hand = hand.map {|e| e.to_s}
  return hand
end

def uses_available_letters?(input, letters_in_hand)
  word = input.upcase.chars
  result = true
  word.each do |letter|
    if word.count(letter) > letters_in_hand.count(letter)
      return false
    end
  end
  return true
end

def score_word(word)
  word = word.upcase
  score = 0
  if word.chars.length > 6
    score += 8 
  end
  word.chars.each do |letter|
    case letter
      when "D","G"
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
        score += 1
    end
  end
  return score
end

def highest_score_from(words)
  win_word = ""
  win_score = 0
  words.each do |current_word|
    current_score = score_word(current_word)
      if current_score > win_score || (current_score == win_score && # current score wins or its a tie
         (!(win_word.length == current_word.length || win_word.length == 10) && # is previous winning word 10 chars, or is it the same length as new word?
          (current_word.length == 10 || current_word.length < win_word.length))) # check to see if current word is 10, then check for which is the smallest
          win_word = current_word
          win_score = current_score   
      end
  end
  return {
      word: win_word,
      score: win_score
    }
end

def is_in_english_dict?(input)
  input = input.chomp.downcase
  if input.length > 0
    CSV.foreach('assets/dictionary-english.csv') do |word|
      if input == word[0]
        return true
      end
    end
  end
    return false
end