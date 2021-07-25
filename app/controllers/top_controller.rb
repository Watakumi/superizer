class TopController < ApplicationController
  def index
    params[:sentence] = "気持ちいい" unless params[:sentence].present?
    @sentence = params[:sentence]
    natto_client = NattoClient.new(@sentence)
    @superized_sentence = natto_client.superized_sentence
  end
end
