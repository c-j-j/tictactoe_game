require 'spec_helper'
require 'game'
require 'board'
require 'lib/stubs/stub_interface'
require 'lib/stubs/stub_player'
require 'lib/helpers/board_helper'

describe TTT::Game do
  let(:board) { TTT::Board.new(3) }
  let(:board_helper) { TTT::BoardHelper.new }
  let(:stub_player_1) { TTT::StubPlayer.new('X') }
  let(:stub_player_2) { TTT::StubPlayer.new('O') }
  let(:game) { TTT::Game.new(board, stub_player_1, stub_player_2) }

  it 'current player set to player 1 when board is empty' do
    expect(game.determine_current_player).to eq(stub_player_1)
  end

  it 'current player set to player 2 when odd number of moves made' do
    board_helper.add_moves_to_board(board, [0], stub_player_1.mark)
    expect(game.determine_current_player).to eq(stub_player_2)
  end

  it 'gets row size from board' do
    expect(game.row_size).to eq(board.rows.size)
  end

  it 'gets number of positions from board' do
    expect(game.number_of_positions).to eq(board.number_of_positions)
  end

  it 'checks with board if move is valid' do
    expect(game.move_valid?(-1)).to eq(board.is_move_valid?(-1))
  end

  it 'nil move is valid' do
    expect(game.move_valid?(nil)).to be(true)
  end

  it 'builds hvh game' do
    game = TTT::Game.build_game(TTT::Game::HVH, 3)
    expect(game.player_1).to be_kind_of(TTT::HumanPlayer)
    expect(game.player_2).to be_kind_of(TTT::HumanPlayer)
    expect(game.player_1.mark).to eq(TTT::Game::X)
    expect(game.player_2.mark).to eq(TTT::Game::O)
  end

  it 'builds hvc game' do
    game = TTT::Game.build_game(TTT::Game::HVC, 3)
    expect(game.player_1).to be_kind_of(TTT::HumanPlayer)
    expect(game.player_2).to be_kind_of(TTT::ComputerPlayer)
    expect(game.player_1.mark).to eq(TTT::Game::X)
    expect(game.player_2.mark).to eq(TTT::Game::O)
  end

  it 'builds cvh game based on user input' do
    game = TTT::Game.build_game(TTT::Game::CVH, 3)
    expect(game.player_1).to be_kind_of(TTT::ComputerPlayer)
    expect(game.player_2).to be_kind_of(TTT::HumanPlayer)
    expect(game.player_1.mark).to eq(TTT::Game::X)
    expect(game.player_2.mark).to eq(TTT::Game::O)
  end

  it 'builds cvc game based on user input' do
    game = TTT::Game.build_game(TTT::Game::CVC, 3)
    expect(game.player_1).to be_kind_of(TTT::ComputerPlayer)
    expect(game.player_2).to be_kind_of(TTT::ComputerPlayer)
    expect(game.player_1.mark).to eq(TTT::Game::X)
    expect(game.player_2.mark).to eq(TTT::Game::O)
  end

  it 'default board size is 3' do
    expect(TTT::Game.default_board_size).to eq(3)
  end

  it 'default game type is HVH' do
    expect(TTT::Game.default_game_type).to eq(TTT::Game::HVH)
  end

  it 'includes board in game presenter' do
    game_presenter = game.presenter
    expect(game_presenter.board).to eq(board)
  end

  it 'includes row size in game presenter' do
    game_presenter = game.presenter
    expect(game_presenter.row_size).to eq(3)
  end

  it 'status set to InProgress when no winner' do
    game_presenter = game.presenter
    expect(game_presenter.state).to eq(TTT::Game::IN_PROGRESS)
  end

  it 'status set to win when game has been won' do
    board_helper.populate_board_with_win(board, stub_player_1.mark)
    game_presenter = game.presenter
    expect(game_presenter.state).to eq(TTT::Game::WON)
  end

  it 'status set to winner when game has been won' do
    board_helper.populate_board_with_win(board, stub_player_1.mark)
    game_presenter = game.presenter
    expect(game_presenter.winner).to eq(stub_player_1.mark)
  end

  it 'status set to draw when game is a draw' do
    board_helper.populate_board_with_tie(board, stub_player_1, stub_player_2)
    game_presenter = game.presenter
    expect(game_presenter.state).to eq(TTT::Game::DRAW)
  end

  it 'asks next player for move and adds to board' do
    stub_player_1.prepare_next_move(2)
    game.play_turn
    expect(game.board.get_mark_at_position(2)).to eq(stub_player_1.mark)
  end

  it 'does not add move to board when game is over' do
    board_helper.add_moves_to_board(board, [0, 1, 2], stub_player_1.mark)
    stub_player_2.prepare_next_move(3)
    game.play_turn
    expect(game.board.get_mark_at_position(3)).to eq(nil)
  end

  it 'plays a move provided to it and adds to board' do
    game.add_move(2)
    expect(game.board.get_mark_at_position(2)).to eq(stub_player_1.mark)
  end

  it 'response says if current player is a ComputerPlayer' do
    game = TTT::Game.build_game(TTT::Game::CVC, 4)
    game_presenter = game.presenter
    expect(game_presenter.current_player_is_computer).to eq(true)
  end

  it 'response says if current player is not a ComputerPlayer' do
    game = TTT::Game.build_game(TTT::Game::HVH, 4)
    game_presenter = game.presenter
    expect(game_presenter.current_player_is_computer).to eq(false)
  end

  it 'provides board positions' do
    expect(game.board_positions).to eq(board.positions)
  end
end
