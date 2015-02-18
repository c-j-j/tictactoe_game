require 'tictactoe/game_presenter'
require 'tictactoe/game'

describe TicTacToe::GamePresenter do

  it 'creates game presenter with board' do
    game_presenter = TicTacToe::GamePresenter::Builder.new
      .with_board('board')
      .build
    expect(game_presenter.board).to eq('board')
  end

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

  it 'creates game presenter with row_size' do
    game_presenter = TicTacToe::GamePresenter::Builder.new
      .with_row_size('row_size')
      .build
    expect(game_presenter.row_size).to eq('row_size')
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
      .with_row_size(3)
      .build

    expect(game_presenter.cell_size).to eq('32%')
  end

  it 'cell size is 24% when board is 4x4' do
    game_presenter = TicTacToe::GamePresenter::Builder.new
      .with_row_size(4)
      .build

    expect(game_presenter.cell_size).to eq('24%')
  end
end
