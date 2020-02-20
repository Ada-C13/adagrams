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
  hand = letter_in_hand.clone
  input.each_with_index { |av, ai|
    hand.each_with_index { |bv, bi|
      if (av == bv)
        input[ai] = nil
        hand.delete_at(bi)
      end
    }
  }
  input.reject!{ |item| item.nil? }
  return input.empty?
end

def score_word(word)
  score_values = 
   {'A'=> 1,
    'B'=> 3,
    'C'=> 3,
    'D'=> 2,
    'E'=> 1,
    'F'=> 4,
    'G'=> 2,
    'H'=> 4,
    'I'=> 1,
    'J'=> 8,
    'K'=> 5,
    'L'=> 1,
    'M'=> 3,
    'N'=> 1,
    'O'=> 1,
    'P'=> 3,
    'Q'=> 10,
    'R'=> 1,
    'S'=> 1,
    'T'=> 1,
    'U'=> 1,
    'V'=> 4,
    'W'=> 4,
    'X'=> 8,
    'Y'=> 4,
    'Z'=> 10,
  }
  total = 0
  word.upcase.each_char { |letter|
  total += score_values[letter]
  }
  if word.length > 6
  total += 8
  end

  return total
end


def highest_score_from(words) 
  print 'words->', words
  game_scores = words.map do |word|
    game_scores = {:word => word, :score => score_word(word)}
  end 

  max_score = 0
  best_word = nil
  shortest = []
  tied_words = []
  
  game_scores.each do |banana|
    current_score = banana[:score]
    if current_score > max_score
      max_score = current_score
      tied_words = [banana]
    elsif current_score == max_score
      tied_words << banana
    end
  end

  return tied_words[0] if tied_words.length == 1

  tied_words.each do |i|
    if i[:word].length == 10
      return i
    end
  end 

  tied_words.each do |i|
    shortest << i[:word].length
  end

  tied_words.each do |i|
    if shortest.min == i[:word].length
      return i
    end
  end

end