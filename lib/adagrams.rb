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
  word_letters = Array.new
  letters_in_hand.each do |n|
    if word.include? n
      word_letters << n
    end
  end
  p word_letters
  if word.sort == word_letters.sort
    return true
  end
  return false
end


def score_word(word)
 word.chars.each do |letter|
  
 
 end
end