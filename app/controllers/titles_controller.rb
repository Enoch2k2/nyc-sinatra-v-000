class TitlesController < ApplicationController

  get '/titles' do
    @titles = Title.all
    erb :'titles/index'
  end

  get '/titles/new' do
    erb :'titles/new'
  end

end
