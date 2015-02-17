require 'board'

module TTT
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
        board_string.split(//).each do |cell_representation|
          mark_representation =extract_mark(cell_representation)
          positions << mark_representation
        end
        TTT::Board.new_board_with_positions(positions)
      end

      def self.extract_mark(cell_representation)
        mark = cell_representation
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
