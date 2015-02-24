module TicTacToe
  class GamePresenter
    TIE_MESSAGE = 'Game is a tie.'
    WINNING_MESSAGE = '%s has won.'
    NEXT_PLAYER_TO_GO = '%s\'s turn.'
    EMPTY_MARK = 'E'

    attr_accessor :board, :state, :winner, :current_player_mark, :row_size

    def status
      if @state == TicTacToe::Game::DRAW
        TIE_MESSAGE
      elsif @state == TicTacToe::Game::WON
        WINNING_MESSAGE % @winner
      else
        NEXT_PLAYER_TO_GO % @current_player_mark
      end
    end

    def cell_size
      return '24%' if row_size == 4
      '32%'
    end

    def board
      raise 'GamePresenter.board method deprecated. Call board_positions instead'
    end

    def row_size
      @board.row_size
    end

    def board_as_array
      board_position_array = []
      (0...@board.number_of_positions).each_with_index do |index|
        board_position_array << @board.get_mark_at_position(index)
      end
      board_position_array
    end

    def board_as_string
      output = ""
      (0...@board.number_of_positions).each_with_index do |index|
        mark = @board.get_mark_at_position(index) || EMPTY_MARK
        output << "#{mark}"
      end
      output
    end


    def self.build_board_from_string(board_string)
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

    class Builder
      def initialize
        @game_presenter = GamePresenter.new
      end

      def with_board(board)
        @game_presenter.board = board
        return self
      end

      def with_state(state)
        @game_presenter.state = state
        return self
      end

      def with_winner(winner)
        @game_presenter.winner = winner
        return self
      end

      def with_current_player_mark(current_player_mark)
        @game_presenter.current_player_mark = current_player_mark
        return self
      end

      def with_current_player_is_computer(current_player_is_computer)
        @game_presenter.current_player_is_computer = current_player_is_computer
        return self
      end

      def build
        @game_presenter
      end
    end
  end
end
