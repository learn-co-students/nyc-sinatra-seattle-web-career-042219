class FiguresController < ApplicationController

get '/figures' do
  @figures = Figure.all
erb :'figures/index'
end

get '/figures/new' do
  @titles = Title.all
  @landmarks = Landmark.all
  erb :'figures/new'
end

get '/figures/:id' do
@figure = Figure.find(params[:id])
erb :'figures/show'
end

post '/figures' do
@figure = Figure.create(name: params["figure_name"])
  if params["title[name]"] != ""
    @figure.titles << Title.create(params[:title])
  end
  if params["landmark[name]"] != ""
    @figure.landmarks << Landmark.create(params[:landmark])
  end
  if params["figure"]
    if params["figure"]["title_ids"]
      params["figure"]["title_ids"].each do |id|
      @figure.titles << Title.find(id)
      end
    end
    if params["figure"]["landmark_ids"]
      params["figure"]["landmark_ids"].each do |id|
      @figure.landmarks << Landmark.find(id)
      end
    end
  end
  redirect "figures/#{@figure.id}"
end

get '/figures/:id/edit' do
  @titles = Title.all
  @landmarks = Landmark.all
  @figure = Figure.find(params[:id])

  erb :'figures/edit'
end

patch '/figures/:id' do
  @figure = Figure.find(params[:id])
  @figure.update(name: params["figure_name"])
  if params["figure"]
    @figure.update(params["figure"])
  end
  if params["title[name]"] != ""
    @figure.titles << Title.create(params[:title])
  end
  if params["landmark[name]"] != ""
    @figure.landmarks << Landmark.create(params[:landmark])
  end
    redirect "figures/#{@figure.id}"
end


  # add controller methods
end
