require 'tictactoe/human_player'
require 'tictactoe/board'
require 'tictactoe/game'

describe TicTacToe::HumanPlayer do
  let(:board){TicTacToe::Board.new(3)}
  let(:player){TicTacToe::HumanPlayer.new('X')}

  it 'returns move not available' do
    expect(player.next_move(board)).to eq(TicTacToe::Game::MOVE_NOT_AVAILABLE)
  end

  it 'uses factory to build human player with mark' do
    human_player_factory = TicTacToe::HumanPlayer::Factory.new
    human_player = human_player_factory.build_with_mark('X')
    expect(human_player.mark).to eq('X')
  end
end
