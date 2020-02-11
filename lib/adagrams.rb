# (1)
# Draw 10 random letters

# Base - draw_letters method
# need to have a letter pool
# generate the whole alphabet

# print letter_pool
letter = []
letter = ('a'..'z').to_a
quantity = [9, 2,	2, 4, 12, 2,	3, 2, 9, 1, 1, 4, 2, 6, 8, 2, 1, 6, 4, 6, 4, 2, 2, 1, 2, 1]
puts letter
puts quantity.length


def create_letter_pool(letter, quantity)
  index = 0
  letter_pool = []
  letter.each_with_index do |letter, index|
    letter_pool.fill(letter, letter_pool.size, quantity[index])
  end
  return letter_pool
end

print create_letter_pool(letter, quantity)