class FiguresController < ApplicationController
  # add controller methods
  set :views, 'app/views/figures/'


  get '/figures' do
    @figures = Figure.all
    erb :index
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :new
  end

  post '/figures' do
    figure = Figure.create(name: params[:figure][:name])

    if params[:figure].keys.include?("title_ids")
        params[:figure][:title_ids].each do |title_id|
        figure_title = FigureTitle.create(title_id: title_id, figure_id: figure.id)
        # figure.titles << Title.find(title_id)
      end
    end

    if !params[:title][:name].empty?
      title = Title.create(name: params[:title][:name])
      figure_title = FigureTitle.create(title_id: title.id, figure_id: figure.id)
      # figure.titles << title
    end


  if params[:figure].keys.include?("landmark_ids")
    params[:figure][:landmark_ids].each do |landmark_id|
      landmark = Landmark.find(landmark_id)
      landmark.update(figure_id: figure.id)
      # figure.landmarks << landmark
    end
  end

  if !params[:landmark][:name].empty?
    landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year], figure_id: figure.id)
    # figure.landmarks << landmark
  end

    redirect '/figures'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :show
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :edit
  end

  patch '/figures/:id' do
    figure = Figure.find(params[:id])

    if params[:figure][:name] != figure.name
      figure.update(name: params[:figure][:name])
    end

    if params[:figure].keys.include?("title_ids")
        params[:figure][:title_ids].each do |title_id|
        figure_title = FigureTitle.create(title_id: title_id, figure_id: figure.id)
        # figure.titles << Title.find(title_id)
      end
    end

    if !params[:title][:name].empty?
      title = Title.create(name: params[:title][:name])
      figure_title = FigureTitle.create(title_id: title.id, figure_id: figure.id)
      # figure.titles << title
    end


  if params[:figure].keys.include?("landmark_ids")
    params[:figure][:landmark_ids].each do |landmark_id|
      landmark = Landmark.find(landmark_id)
      landmark.update(figure_id: figure.id)
      # figure.landmarks << landmark
    end
  end

  if !params[:landmark][:name].empty?
    landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year], figure_id: figure.id)
    # figure.landmarks << landmark
  end

    redirect "/figures/#{@figure.id}"
  end
end
