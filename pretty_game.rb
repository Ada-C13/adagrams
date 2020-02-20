require_relative 'lib/adagrams'

puts "Welcome to Adagrams! How many hands would you like to play?"
num_rounds_to_play = gets.chomp

until num_rounds_to_play == num_rounds_to_play.to_i.to_s
  puts "Sorry that's not an integer. Please try again"
  num_rounds_to_play = gets.chomp
end

user_words = []

num_rounds_to_play.to_i.times do
  letters_in_hand = draw_letters
  puts "Here are 10 letters for you from a random draw:"
  print letters_in_hand
  puts "\n"
  
  puts "Please use the letters above and give me a word."
  user_input = gets.chomp.upcase
  
  used_available_letters = uses_available_letters?(user_input, letters_in_hand)
  dictionary_word = is_in_english_dict?(user_input)
    
  until used_available_letters == true && dictionary_word == true
    puts "Sorry, this is not a valid word. Please try again."
    user_input = gets.chomp.upcase
    used_available_letters = uses_available_letters?(user_input, letters_in_hand)
    dictionary_word = is_in_english_dict?(user_input)
  end

  
  user_words.push(user_input)



  puts "The score of #{user_input} is: #{score_word(user_input)}"
  puts ".........................."
end

puts "\n\n"

puts "Congrats! The winning word was #{highest_score_from(user_words)[:word]} with a score of #{highest_score_from(user_words)[:score]}"