require 'game'

module TTT
  class HumanPlayer

    attr_reader :mark

    def initialize(mark)
      @mark = mark
    end

    def next_move(board)
      Game::MOVE_NOT_AVAILABLE
    end
  end
end
