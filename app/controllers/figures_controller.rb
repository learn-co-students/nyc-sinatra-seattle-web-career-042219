require 'pry'
class FiguresController < ApplicationController
  # add controller methods
  get '/' do
    redirect "/figures"
  end

  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :"figures/new"
  end


  post '/figures' do

    if !params[:figure].keys.include?("title_ids")
      params[:figure]['title_ids'] = []
    end

    if !params[:figure].keys.include?("landmark_ids")
      params[:figure]['landmark_ids'] = []
    end


    @figure = Figure.create(name: params['figure']['name'])

    params['figure']['title_ids'].each do |id|
      @figure.titles << Title.find(id.to_i)
    end

# binding.pry
    if !params['landmark']['name'].empty?

      @landmark = Landmark.create(name: params['landmark']['name'], year_completed: params['landmark']['year'])
      @figure.landmarks << @landmark
    end

    if !params['figure']['landmark_ids'].empty?
      params['figure']['landmark_ids'].each do |id|
        @figure.landmarks << Landmark.find(id.to_i)
      end
    end

    #binding.pry
    if !params['title']['name'].empty?
      @title = Title.create(name: params['title']['name'])
      @figure.titles << @title
    end

    if !params['figure']['title_ids'].empty?
      params['figure']['title_ids'].each do |id|
        @figure.titles << Title.find(id.to_i)
      end
    end

    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params['id'])

    erb :"figures/edit"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])

    erb :"figures/edit"
  end

  patch '/figures/:id' do
      @figure = Figure.find(params[:id])
      @figure.update(name: params[:figure]['name'])
      @figure.landmarks << Landmark.create(name: params[:figure][:landmark])

      if !params[:figure].keys.include?("title_ids")
        params[:figure]['title_ids'] = []
        @figure.titles = []
      end

      #binding.pry
      @figure.titles << params[:figure]['title_ids']

      redirect "/figures/#{@figure.id}"
  end


end
