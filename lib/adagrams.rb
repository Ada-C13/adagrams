# Creating letter pool
letter = ('A'..'Z').to_a
quantity = [9, 2, 2, 4, 12, 2, 3, 2, 9, 1, 1, 4, 2, 6, 8, 2, 1, 6, 4, 6, 4, 2, 2, 1, 2, 1 ]

def create_letter_pool(letter, quantity)
  index = 0
  letter_pool = []
  letter.each_with_index do |letter, index|
    letter_pool.fill(letter, letter_pool.size, quantity[index])
  end
  return letter_pool
end
letter_pool_array = create_letter_pool(letter, quantity)

# Wave (1)
# Method to draw 10 random letters
def draw_letters
  # Welcome message
    puts "Welcome to Adagrams!"
    puts "Let's draw 10 letters from the letter pool..."
    puts "You have drawn the letters:"
    
    letter = ('A'..'Z').to_a
    quantity = [9, 2, 2, 4, 12, 2, 3, 2, 9, 1, 1, 4, 2, 6, 8, 2, 1, 6, 4, 6, 4, 2, 2, 1, 2, 1 ]
   
  # Use the create_letter_pool method
    create_letter_pool(letter, quantity)
    letter_pool_array = create_letter_pool(letter, quantity)
    
  # Shuffle the letter pool
    letter_pool_array = letter_pool_array.shuffle()
    letters = letter_pool_array.sample(10) # Not sure if it will have more than 2 Cs
    letter.join(', ')
    return drawn_letters = letters
end
draw_letters
print draw_letters.join(', ')