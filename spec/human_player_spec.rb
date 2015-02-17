require 'spec_helper'
require 'human_player'
require 'board'
require 'game'

describe TTT::HumanPlayer do
  let(:board){TTT::Board.new(3)}
  let(:player){TTT::HumanPlayer.new('X')}

  it 'returns move not available' do
    expect(player.next_move(board)).to eq(TTT::Game::MOVE_NOT_AVAILABLE)
  end

end
