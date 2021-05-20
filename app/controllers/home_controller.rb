class HomeController < ApplicationController
  def index
    @candles = Candle.all.sample(10)
  end
end
