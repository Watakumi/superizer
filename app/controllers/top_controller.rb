class TopController < ApplicationController
  def index
    @sentence = params[:sentence]
  end
end
