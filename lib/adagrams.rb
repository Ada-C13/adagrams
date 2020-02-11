#Game for user to create words.

# Wave 1
#Create hash with number of each tile available. Randomly sample 10.
def draw_letters
  all_tiles = {
    A: 9, B: 2, C: 2, D: 4, E: 12, F: 2, G: 3, H: 2, I: 9, J: 1, K: 1, L: 4, M: 2,
    N: 6, O: 8, P: 2, Q: 1, R: 6, S: 4, T: 6, U: 4, V: 2, W: 2, X: 1, Y: 2, Z: 1
  }
  tile_array = []
  all_tiles.each do |letter, number|
    number.times do
      tile_array.push(letter.to_s)
    end
  end
  tile_array.sample(10)
end

#Wave 2
#Confirms that the user input only uses ones that are available in their hand
def uses_available_letters? (input, letters_in_hand) #doesn't address duplicated letters
  input.split(//).each do |letter|
    if (letters_in_hand.include? letter.upcase) == false
      return false
    end
    letters_in_hand -= [letter.upcase]
  end
  true
end