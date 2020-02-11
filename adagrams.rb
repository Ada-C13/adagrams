def draw_letters
    letter_choices = Array('A'..'Z')
    user_hand = Array.new() 
    user_hand << letter_choices.sample(10)

    puts user_hand.count("J")
    p user_hand
end

draw_letters