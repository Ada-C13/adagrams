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
  puts hand
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
  words.each do |word|
    current_score = score_word(word)
      if current_score == win_score
        if win_word.length == word.length || win_word.length == 10
          # no change
        elsif word.length == 10 || word.length < win_word.length
          win_word = word 
        end  
      elsif current_score > win_score
        win_score = current_score
        win_word = word
      end
  end
  return {
      word: win_word,
      score: win_score
    }
end

def is_in_english_dict?(input)
  CSV.foreach('assets/dictionary-english.csv') do |word|
    if input == word[0]
      p word[0]
      return true
    end
  end
  return false
end

       