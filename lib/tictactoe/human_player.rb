require 'tictactoe/game'

module TicTacToe
  class HumanPlayer

    attr_reader :mark

    def initialize(mark)
      @mark = mark
    end

    def next_move(board)
      Game::MOVE_NOT_AVAILABLE
    end

    class Factory
      def build_with_mark(mark)
        TicTacToe::HumanPlayer.new(mark)
      end
    end
  end
end
