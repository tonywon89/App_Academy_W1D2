require './card.rb'

class Board
  GRID_ROWS = 2
  GRID_COLS = 2
  attr_accessor :grid

  def initialize(grid = Array.new(GRID_ROWS) { Array.new(GRID_COLS) })
    @grid = grid
  end

  def populate
    cards = make_cards.shuffle
    (0...GRID_ROWS).each do |row|
      (0...GRID_COLS).each do |col|
        @grid[row][col] = cards.shift
      end
    end
  end

  def render
    display = grid.map do |row|
      row.map do |card|
        card.face_up ? card.display : :x
      end
    end
    display.each do |row|
      p row
    end
  end

  def [](row, col)
    grid[row][col]
  end

  def []=(row, col, card)
    @grid[row][col] = card
  end

  def won?
    grid.flatten.all? { |card| card.face_up }
  end

  def reveal(guessed_pos)
    row, col = guessed_pos
    card = grid[row][col]
    card.reveal
  end

  def row_range
    grid.size - 1
  end

  def col_range
    grid[0].size - 1
  end

  def valid_move?(guess)
    valid_range?(guess) && hidden_card?(guess)
  end

  def valid_range?(pos)
    row, col = pos
    if !(row > row_range || row < 0 || col > col_range || col < 0 )
      true
    else
      puts "That is not a valid range. Try again."
    end
  end

  def hidden_card?(pos)
    row, col = pos
     if !grid[row][col].face_up
       true
     else
       puts "That is a revealed card, so it is not a valid selection. Try Again."
       false
     end
  end


  #private
  def make_cards
    stack_of_cards = []
    (num_of_board_spaces/2).times do |value|
      2.times { stack_of_cards << Card.new(value) }
    end
    stack_of_cards
  end

  def num_of_board_spaces
    grid.flatten.length
  end

end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.populate
  board.render
  puts
  board.reveal([1,1])
  board.render
end
