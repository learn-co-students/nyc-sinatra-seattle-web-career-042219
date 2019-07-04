class FiguresController < ApplicationController
  # add controller methods
  set :views, 'app/views/figures/'

  get '/figures' do
    @figures = Figure.all
    erb :index
  end

  get '/figures/new' do
    erb :new
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :show
  end

  post '/figures' do
    #binding.pry
    if !params[:figure].keys.include?("title_ids")
      params[:figure]["title_ids"] = []
    end


    @figure = Figure.create(name: params[:figure][:name])
    if !params[:figure][:title_ids].empty?
      params[:figure][:title_ids].each do |id|
        @figure.titles << Title.find(id)
      end
    end
    if !params[:title][:name].empty?
      @figure.titles << Title.create(name: params[:title][:name])
    end

    if !params[:figure].keys.include?("landmark_ids")
      params[:figure]["landmark_ids"] = []
    end
    if !params[:figure][:landmark_ids].empty?
      params[:figure][:landmark_ids].each do |id|
        @landmark = Landmark.find(id)
        @figure.landmarks << @landmark.update(name: @landmark.name, figure_id: @figure.id, year_completed: @landmark.year_completed)
      end
    end
    if !params[:landmark][:name].empty?
      @landmark = Landmark.create(name: params[:landmark][:name], figure_id: @figure.id, year_completed: params[:landmark][:year_completed])
      @figure.landmarks << @landmark
    end
    #binding.pry
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :edit
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(name: params[:figure][:name])
    if !params[:figure].keys.include?("title_ids")
      params[:figure]["title_ids"] = []
      #@figure.titles = []
    end

    if !params[:figure][:title_ids].empty?
      params[:figure][:title_ids].each do |id|
        @figure.titles << Title.find(id)
      end
    end
    if !params[:title][:name].empty?
      @figure.titles << Title.create(name: params[:title][:name])
    end

    if !params[:figure].keys.include?("landmark_ids")
      params[:figure]["landmark_ids"] = []
      #@figure.landmarks =
    end
    if !params[:figure][:landmark_ids].empty?
      params[:figure][:landmark_ids].each do |id|
        @landmark = Landmark.find(id)
        @figure.landmarks << @landmark.update(name: @landmark.name, figure_id: @figure.id, year_completed: @landmark.year_completed)
      end
    end
    if !params[:landmark][:name].empty?
      @landmark = Landmark.create(name: params[:landmark][:name], figure_id: @figure.id, year_completed: params[:landmark][:year_completed])
      @figure.landmarks << @landmark
    end

     redirect "/figures/#{@figure.id}"
  end

end
