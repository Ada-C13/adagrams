#make the data structure for all the letters and the number of letters availble

def draw_letters
  sample = {
    "a" => 9,
    "b" => 2,
    "c" => 2,
    "d" => 4,
    "e" => 12,
    "f" => 2,
    "g" => 3,
    "h" => 2,
    "i" => 9,
    "j" => 1,
    "k" => 1,
    "l" => 4,
    "m" => 2,
    "n" => 6,
    "o" => 8,
    "p" => 2,
    "q" => 1,
    "r" => 6,
    "s" => 4,
    "t" => 6,
    "u" => 4,
    "v" => 2,
    "w" => 2,
    "x" => 1,
    "y" => 2,
    "z" => 1,
  }
  pool_letters = []
  sample.each do |letter, quantity|
    quantity.times do
      pool_letters << letter
    end
  end
  #randomize the pool of letters
  pool_letters = pool_letters.sample(pool_letters.length)
  #display the 10 letters they have drawn
  return pool_letters.first(10)
end
#Since there are 12 Es but only 1 Z, it should be 12 times as likely for the user to draw an E as a Z
puts "😎=> control, command, space"