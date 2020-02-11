# Wave 1

def draw_letters
  pool = {
    A: Array.new(9, "A"),
    B: Array.new(2, "B"),
    C: Array.new(2, "C"),
    D: Array.new(4, "D"),
    E: Array.new(12, "E"),
    F: Array.new(2, "F"),
    G: Array.new(3, "G"),
    H: Array.new(2, "H"),
    I: Array.new(9, "I"),
    J: Array.new(1, "J"),
    K: Array.new(1, "K"),
    L: Array.new(4, "L"),
    M: Array.new(2, "M"),
    N: Array.new(6, "N"),
    O: Array.new(8, "O"),
    P: Array.new(2, "P"),
    Q: Array.new(1, "Q"),
    R: Array.new(6, "R"),
    S: Array.new(4, "S"),
    T: Array.new(6, "T"),
    U: Array.new(4, "U"),
    V: Array.new(2, "V"),
    W: Array.new(2, "W"),
    X: Array.new(1, "X"),
    Y: Array.new(2, "Y"),
    Z: Array.new(1, "Z")
  }

  pool_values = pool.map do |key, value|
    value
  end

  pool_final = pool_values.flat_map do |letter|
    letter
  end

  user_took = []

  10.times do |i|
    pool_final.shuffle!
    user_took << pool_final.slice!(0)
  end

  return user_took
end 

user_1 = draw_letters
user_2 = draw_letters

p user_1
p user_2


# p pool_final.length
# p user_took 
# p pool_final.sort


# Wave 2.
def uses_available_letters?(input, letters_in_hand)
  input = input.split("")

  letters_in_hand.each do |letter|
    i = 0
    if i == input.index(letter)
      input.slice!(i)
    end

    i += 1
  end

  return input.empty?
end