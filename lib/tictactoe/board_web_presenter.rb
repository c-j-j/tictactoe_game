require 'tictactoe/board'

module TicTacToe
  module Web
    class BoardWebPresenter

      EMPTY_MARK = 'E'

      def self.to_web_object(board)
        output = ""
        board.positions.each_with_index do |mark, position|
          mark_representation = mark || EMPTY_MARK
          output << "#{mark_representation}"
        end
        output
      end

      def self.to_board(board_string)
        positions = []
        board_string.split(//).each do |cell|
          mark_representation =extract_mark(cell)
          positions << mark_representation
        end
        TicTacToe::Board.new_board_with_positions(positions)
      end

      def self.extract_mark(cell)
        mark = cell
        if (mark == EMPTY_MARK)
          nil
        else
          mark
        end
      end

      def self.split_into_pairs(board_string)
        board_string.scan(/.{2}/)
      end
    end
  end
end