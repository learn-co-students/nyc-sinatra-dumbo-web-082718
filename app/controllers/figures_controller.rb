class FiguresController < ApplicationController
  # add controller methods

  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"figures/new"
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])

    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
      @figure.save
    end

    if !params[:landmark][:name].empty? || !params[:landmark][:year_completed].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
      @figure.save
    end

    redirect to "/figures/#{@figure.id}"
  end

  get "/figures/:id" do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end

  get "/figures/:id/edit" do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"figures/edit"
  end

  patch "/figures/:id" do
    @figure = Figure.find(params[:id])

    if !params[:figure].keys.include?("landmark_ids")
      params[:figure][:landmark_ids] = []
    end

    if !params[:figure].keys.include?("title_ids")
      params[:figure][:title_ids] = []
    end


    @figure.update(params[:figure])
    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end

    if !params[:landmark][:name].empty? || !params[:landmark][:year_completed].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    @figure.save

    redirect to "/figures/#{@figure.id}"
  end

end
