require 'pry'
require 'rack-flash'
class FiguresController < ApplicationController
  use Rack::Flash

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end

  post '/figures' do
    figure = Figure.create(name: params[:figure][:name])
    figure.update(landmark_ids: params[:figure][:landmark_ids]) unless params[:figure][:landmark_ids].nil?
    figure.landmarks.create(name: params[:landmark][:name]) unless params[:landmark][:name].empty?
    figure.update(title_ids: params[:figure][:title_ids]) unless params[:figure][:title_ids].nil?
    figure.titles.create(name: params[:title][:name]) unless params[:title][:name].empty?
    figure.save
    flash[:message] = "Successfully created Figure"
    redirect to "/figures/#{figure.id}"
  end

  patch '/figures/:id' do
    figure = Figure.find(params[:id])
    figure.name = params[:figure][:name] unless params[:figure][:name].empty?
    figure.update(landmark_ids: params[:figure][:landmark_ids]) unless params[:figure][:landmark_ids].nil?
    figure.landmarks.create(name: params[:landmark][:name]) unless params[:landmark][:name].empty?
    figure.update(title_ids: params[:figure][:title_ids]) unless params[:figure][:title_ids].nil?
    figure.titles.create(name: params[:title][:name]) unless params[:title][:name].empty?
    figure.save
    flash[:message] = "Successfully updated Figure"
    redirect to "/figures/#{figure.id}"
  end
end
