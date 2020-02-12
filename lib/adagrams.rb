def draw_letters
  # Letters      A  B  C  D  E   F  G  H  I  J  K  L  M  N  O  P  Q  R  S  T  U  V  W  X  Y  Z
  letter_dist = [9, 2, 2, 4, 12, 2, 3, 2, 9, 1, 1, 4, 2, 6, 8, 2, 1, 6, 4, 6, 4, 2, 2, 1, 2, 1]
  hand_size   = 10
  letter_a_offset = 65# 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90
  
  letter_pool = letter_dist.map.with_index { |dist, index| (index + letter_a_offset).chr * dist }
  return letter_pool.join('').split('').sample(hand_size)
  # ("A".."Z").each do |letter|
  #   dist = letter_dist[letter.ord - letter_a_offset]
  #   letter_pool += letter * dist
  # end
  # letter_pool_array = letter_pool.split""
  
  # letter_pool_array = ["A", "A", "A", "A", "A", "A", "A", "A", "A", "B", "B", "C", "C", "D", "D", "D", "D", "E", "E", "E", "E", "E", "E", "E", "E", "E", "E", "E", "E", "F", "F", "G", "G", "G", "H", "H", "I", "I", "I", "I", "I", "I", "I", "I", "I", "J", "K", "L", "L", "L", "L", "M", "M", "N", "N", "N", "N", "N", "N", "O", "O", "O", "O", "O", "O", "O", "O", "P", "P", "Q", "R", "R", "R", "R", "R", "R", "S", "S", "S", "S", "T", "T", "T", "T", "T", "T", "U", "U", "U", "U", "V", "V", "W", "W", "X", "Y", "Y", "Z"]
  
  # return letter_pool_array.sample(10)
end

def uses_available_letters?(input, letter_in_hand)
  hand_copy = letter_in_hand.clone
  input.upcase.split("").each do |letter|
    if hand_copy.include?(letter)
      hand_copy.delete_at(hand_copy.index(letter))
    else
      return false
    end
  end
  return true
  
end


