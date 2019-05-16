class LandmarksController < ApplicationController
  # add controller methods

  set :views, 'app/views/landmarks'

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :index
  end

  get '/landmarks/new' do

    erb :new
  end

  post '/landmarks' do
    landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year])

  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])

    erb :show
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])

    erb :edit
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])

    @landmark.update(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])

    redirect "/landmarks/#{@landmark.id}"
  end

end
