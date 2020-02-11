# (1)
# Draw 10 random letters

# Base - draw_letters method
# need to have a letter pool
# generate the whole alphabet
('a'..'z').to_a

# letter_pool = []
# 9.times do
#   letter_pool << 'a'
# end

# 2.times do
#   letter_pool << 'b'
# end



# letter.with_index do |letter, i|
#   quantity = [9, 2]
#   i.times do
#     letter_pool << letter
#   end
# end


# print letter_pool
letter = []
letter = ('a'..'z').to_a
###### !!!! edit the quantity array
quantity = [9, 2, 2, 4, 12, 2, 3, 2, 9, 1, 1, 4, 2, 6, 8, 2, 1, 6, 4, 6, 4, 2, 1, 2, 1, 1 ]
quantity = [9, 2,	2,	4, 12, 2,	3, 2, 9, 1, 1, 4, 2, 6, 8, 2, 1, 6, 4, 6, 4, 2, 2, 1, 2, 1]
puts letter
puts quantity.length

# letter_pool = []
# letter_pool.fill(letter[0], letter_pool.size, quantity[0])
# puts letter_pool

# letter.each_with_index do |letter, i|
#   quantity = [9, 2]
#   letter_pool.fill(letter[i], letter_pool.size, quantity[0])
# end
# print letter_pool

# def create_specialties_hash(array_1, array_2)
#   i = 1
#   result = []
#   while i <= array_1.size && array_2.size
#     result << {name: array_1[i -1], specialty: array_2[i-1], id: i}
#     i += 1
#   end
# end

# create_specialties_hash(NAMES, SPECIALTIES)

def create_letter_pool(letter, quantity)
  index = 0
  letter_pool = []
  letter.each_with_index do |letter, index|
    letter_pool.fill(letter, letter_pool.size, quantity[index])
  end
  return letter_pool
end

print create_letter_pool(letter, quantity)