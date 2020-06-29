class StaysController < ApplicationController
  def index
    @stays = Stay.all
  end
end
