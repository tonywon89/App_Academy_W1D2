class HumanPlayer
  attr_reader :name

  def initialize(name = "Togan")
    @name = name
  end

  def prompt
    "Hey #{name}, give us your input"
  end

  def get_guess
    guess_to_array(gets.chomp)
  end

  def guess_to_array(guess)
    guess.split(",").map { |num| num.strip.to_i }
  end

end

class ComputerPlayer
  attr_accessor :known_cards, :matched_cards

  def initialize
    @known_cards = {}
    @matched_cards = {}
  end

  def receive_revealed_card(value, pos)
    known_cards[value] = pos
  end

  def receive_match

  end

end
