require 'tictactoe/helpers/board_helper'
require 'tictactoe/board_web_presenter'

describe TicTacToe::Web::BoardWebPresenter do
  let(:board_web_object) { TicTacToe::Web::BoardWebPresenter.new }
  let(:board_helper) { TicTacToe::BoardHelper.new }

  it 'transforms empty board string to empty board' do
    board = TicTacToe::Web::BoardWebPresenter.to_board('EEEEEEEEE')
    expect(board.empty_positions.size).to eq(9)
  end

  it 'transform board to web representation' do
    board = TicTacToe::Board.new(3)
    board_helper.add_moves_to_board(board, [0], 'X')
    expect(TicTacToe::Web::BoardWebPresenter.to_web_object(board)[0]).to eq('X')
  end

  it 'transform web representation to board' do
    board_web_representation = 'XEEEEEEEE'
    board = TicTacToe::Web::BoardWebPresenter.to_board(board_web_representation)
    expect(board.get_mark_at_position(0)).to eq('X')
  end
end
