require 'tictactoe/game_presenter'
require 'tictactoe/game'

describe TicTacToe::GamePresenter do
  let(:board) { TicTacToe::Board.new(3) }

  it 'creates game presenter with state' do
    game_presenter = TicTacToe::GamePresenter::Builder.new
      .with_state('state')
      .build
    expect(game_presenter.state).to eq('state')
  end

  it 'creates game presenter with winner' do
    game_presenter = TicTacToe::GamePresenter::Builder.new
      .with_winner('winner')
      .build
    expect(game_presenter.winner).to eq('winner')
  end

  it 'creates game presenter with current_player_mark' do
    game_presenter = TicTacToe::GamePresenter::Builder.new
      .with_current_player_mark('current_player_mark')
      .build
    expect(game_presenter.current_player_mark).to eq('current_player_mark')
  end

  it 'status is draw message when state is a draw' do
    game_presenter = TicTacToe::GamePresenter::Builder.new
      .with_state(TicTacToe::Game::DRAW)
      .build

    expect(game_presenter.status).to eq(TicTacToe::GamePresenter::TIE_MESSAGE)
  end

  it 'status is winner when state is a win' do
    game_presenter = TicTacToe::GamePresenter::Builder.new
      .with_state(TicTacToe::Game::WON)
      .with_winner('X')
      .build
    expect(game_presenter.status).to eq(TicTacToe::GamePresenter::WINNING_MESSAGE % 'X')
  end

  it 'status displays current player to go' do
    game_presenter = TicTacToe::GamePresenter::Builder.new
      .with_state(TicTacToe::Game::IN_PROGRESS)
      .with_current_player_mark('O')
      .build
    expect(game_presenter.status).to eq(TicTacToe::GamePresenter::NEXT_PLAYER_TO_GO % 'O')
  end

  it 'cell size is 32% when board is 3x3' do
    game_presenter = TicTacToe::GamePresenter::Builder.new
      .with_board(TicTacToe::Board.new(3))
      .build

    expect(game_presenter.cell_size).to eq('32%')
  end

  it 'cell size is 24% when board is 4x4' do
    game_presenter = TicTacToe::GamePresenter::Builder.new
      .with_board(TicTacToe::Board.new(4))
      .build

    expect(game_presenter.cell_size).to eq('24%')
  end

  it 'transforms empty board string to empty board' do
    board = TicTacToe::GamePresenter.build_board_from_string('EEEEEEEEE')
    expect(board.empty_positions.size).to eq(9)
  end

  it 'board positions is enumerable collection' do
    game_presenter = TicTacToe::GamePresenter::Builder.new
      .with_board(TicTacToe::Board.new(3))
      .build
    board_positions = game_presenter.board_as_array
    expect(board_positions.size).to eq(9)
  end

  it 'board positions displayed as string' do
    game_presenter = TicTacToe::GamePresenter::Builder.new
      .with_board(TicTacToe::Board.new(3))
      .build
    board_positions = game_presenter.board_as_string
    expect(board_positions).to eq('EEEEEEEEE')
  end
end
