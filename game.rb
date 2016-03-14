require './board.rb'
require './player.rb'

class Game

  attr_reader :board, :valid_range_text, :player
  def initialize(board = Board.new, player = HumanPlayer.new)
    @board = board
    @player = player
  end

  def play
    setup
    until game_over?
      take_turn
      reset_turn
    end
    puts "You won!"
  end


  private
  attr_accessor :first_card, :second_card

  def reset_turn
    sleep(2)
    system('clear')
    display
  end

  def take_turn
    @first_card, @second_card = nil
    pick_cards
    display
    unless cards_equal?
      @first_card.hide
      @second_card.hide
    end
  end

  def cards_equal?
    @first_card == @second_card
  end

  def pick_cards
    @first_card = pick_card
    display
    @second_card = pick_card
  end


  def pick_card
    pos = obtain_guess_from_player
    card = board[*pos]
    card.reveal
    card
  end

  def obtain_guess_from_player
    player.prompt
    puts "Enter a position (1st: 0-#{board.row_range}, 2nd: 0-#{board.col_range})"
    guess = player.get_guess
    until board.valid_move?(guess)
      guess = player.get_guess
    end
    guess
  end

  def setup
    board.populate
    display
  end

  def display
    board.render
  end

  def game_over?
    board.won?
  end





end

if __FILE__ == $PROGRAM_NAME
  game = Game.new

  game.play


end
