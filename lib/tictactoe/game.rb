require 'tictactoe/human_player'
require 'tictactoe/game_presenter'
require 'tictactoe/computer_player'
require 'tictactoe/board.rb'

module TicTacToe

  class GameType < Struct.new(:game_type, :game_description)
  end

  class Game

    attr_reader :board
    attr_reader :player_1
    attr_reader :player_2
    attr_reader :game_type

    MOVE_NOT_AVAILABLE = -1

    HVH = "HVH"
    HVC = "HVC"
    CVH = "CVH"
    CVC = "CVC"

    GAME_TYPES = [
      GameType.new(HVH, 'Human Vs Human'),
      GameType.new(HVC, 'Human Vs Computer'),
      GameType.new(CVH, 'Computer Vs Human'),
      GameType.new(CVC, 'Computer Vs Computer')
    ]

    BOARD_SIZES = [
      3,
      4
    ]

    WON = :won
    DRAW = :draw
    IN_PROGRESS = :in_progress

    X = 'X'
    O = 'O'

    def self.build_game(game_type, board_size, human_player_factory = TicTacToe::HumanPlayer::Factory.new)
      build_game_with_board(game_type, Board.new(board_size), human_player_factory)
    end

    def self.build_game_with_board(game_type, board, human_player_factory = TicTacToe::HumanPlayer::Factory.new)
      case game_type
      when HVH
        new_game(human_player_factory.build_with_mark(X),
                 human_player_factory.build_with_mark(O), board)
      when HVC
        new_game(human_player_factory.build_with_mark(X),
                 new_computer_player(O, X), board)
      when CVH
        new_game(new_computer_player(X, O),
                 human_player_factory.build_with_mark(O), board)
      when CVC
        new_game(new_computer_player(X, O),
                 new_computer_player(O, X), board)
      end
    end

    def self.default_board_size
      BOARD_SIZES[0]
    end

    def self.default_game_type
      HVH
    end

    def initialize(board, player_1, player_2)
      @board = board
      @player_1 = player_1
      @player_2 = player_2
    end

    def play_turn
      process_move {|current_player| current_player.next_move(@board)}
    end

    def add_move(move)
      process_move { move }
    end

    def presenter
      TicTacToe::GamePresenter::Builder.new
        .with_board(@board)
        .with_current_player_mark(determine_current_player.mark)
        .with_state(determine_state)
        .with_winner(@board.winner)
        .build
    end

    def determine_current_player
      if @board.num_of_occupied_positions.even?
        return @player_1
      else
        return @player_2
      end
    end

    def current_player_is_computer?
      class_name = determine_current_player.class.name
      class_name == TicTacToe::ComputerPlayer.name && !game_over?
    end

    def number_of_positions
      @board.number_of_positions
    end

    def move_valid?(position)
      @board.is_move_valid?(position) && !position.nil?
    end

    def add_move_to_board(position)
      @board.add_move(@current_player.mark, position)
    end

    def game_over?
      @board.game_over?
    end

    private

    def determine_state
      if won?
        WON
      elsif draw?
        DRAW
      else
        IN_PROGRESS
      end
    end

    def process_move(&determine_move)
      unless game_over?
        current_player = determine_current_player
        @board.add_move(current_player.mark, determine_move.call(current_player))
      end
    end

    def determine_if_computer_player(player)
      class_name = player.class.name
      class_name == TicTacToe::ComputerPlayer.name
    end

    def won?
      @board.won?
    end

    def draw?
      @board.draw?
    end

    def self.new_computer_player(mark, opponent_mark)
      TicTacToe::ComputerPlayer.new(mark, opponent_mark)
    end

    def self.new_game(player_1, player_2, board)
      TicTacToe::Game.new(board, player_1, player_2)
    end
  end
end
