def draw_letters
  letters = %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z]
  quantities = [9, 2, 2, 4, 12, 2, 3, 2, 9, 1, 1, 4, 2, 6, 8, 2, 1, 6, 4, 6, 4, 2, 2, 1, 2, 1]

  all_letters = []
  letters.length.times do |i|
    all_letters << (letters[i] * quantities[i]).chars
  end 
  all_letters.flatten!

  hand = all_letters.shuffle.take(10)
  return hand
end


def uses_available_letters?(input, letter_in_hand)
  input = input.chars
  input.each_with_index { |av, ai|
    letter_in_hand.each_with_index { |bv, bi|
      if (av == bv)
        input[ai] = nil
        letter_in_hand.delete_at(bi)
      end
    }
  }
  input.reject!{ |item| item.nil? }
  return input.empty?
end

