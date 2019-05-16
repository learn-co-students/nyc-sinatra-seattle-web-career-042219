class LandmarksController < ApplicationController
  # add controller methods
  get "/landmarks/new" do
    @figures = Figure.all
    erb :'landmarks/new'
  end

  post "/landmarks" do
    @landmark = Landmark.create(params[:landmark])
    # if
    #   !params[:figure][:name].empty?
    #   @landmark.figures << Figure.create(name: params[:figure][:name])
    # =end
    redirect "landmarks/#{@landmark.id}"
  end

  get "/landmarks" do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end

  get "/landmarks/:id" do
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/show'
  end

  get "/landmarks/:id/edit" do
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/edit'
  end

  patch "/landmarks/:id" do
    @landmark = Landmark.find(params[:id])
    @landmark.update(params[:landmark])
    redirect "landmarks/#{@landmark.id}"
  end
end
