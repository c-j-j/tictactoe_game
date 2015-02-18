require 'tictactoe/game'

describe "Integration Tests" do

  it 'runs through cvc game and ends in draw with 3x3 board' do
    cvc_game = TicTacToe::Game.build_game(TicTacToe::Game::CVC, 3)
    until cvc_game.game_over?
      cvc_game.play_turn
    end
    expect(cvc_game.presenter.state).to be(TicTacToe::Game::DRAW)
  end

  xit 'runs through cvc game and ends in draw with 4x4 board' do
    cvc_game = TicTacToe::Game.build_game(TicTacToe::Game::CVC, 4)
    until cvc_game.game_over?
      cvc_game.play_turn
    end
    expect(cvc_game.presenter.state).to be(TicTacToe::Game::DRAW)
  end

end
