class TopController < ApplicationController
  def index
    params[:sentence] = "気持ちいい" if params[:sentence].empty?
    @sentence = params[:sentence]
    natto_client = NattoClient.new(@sentence)
    @superized_sentence = natto_client.superized_sentence
  end
end
