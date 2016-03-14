class Card
  attr_reader :face_value
  attr_accessor :face_up

  def initialize(value)
    @face_value = value
    @face_up = false
  end

  def display
    face_value if face_up
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def to_s

  end

  def ==(other_card)
    face_value == other_card.face_value
  end

end

if __FILE__ == $PROGRAM_NAME
  card1 = Card.new(5)
  card2 = Card.new(6)
  p card1 == card2
end
