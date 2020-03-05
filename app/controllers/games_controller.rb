include FileUtils::Verbose

class GamesController < ApplicationController

  get '/games' do
    @games = Game.all
    erb :'games/index'
  end

  get '/games/new' do
    erb :'games/new'
  end
    
  post "/games" do
      
      tempfile = params[:image][:tempfile] 
      filename = params[:image][:filename]

      timestamp = Time.now.to_i
      image_file = filename.gsub(".", "#{timestamp.to_s}.")
      cp(tempfile.path, "public/uploads/#{image_file}")
      
      @game = Game.new(:name => params[:name], 
                        :short_description => params[:short_description],
                        :description => params[:description],
                        :number_of_players => params[:number_of_players],
                        :play_length => params[:play_length],
                        :image => image_file,
                        :featured => params[:featured] == "on" ? 1 : 0,
                        :created_datetime => timestamp)
      if(!@game.valid?)
          erb :'games/new'
      else
          if @game.save
              redirect to "/games/#{@game.id}"
          else
              redirect '/error'
          end
      end
  end

  get '/games/:id' do
    if logged_in?
      @game = Game.find_by_id(params[:id])
      erb :'games/show'
    else
      redirect '/'
    end
  end

  get '/games/:id/edit' do
    if logged_in?
      @game = Game.find_by_id(params[:id])
      if @game
        erb :'games/edit'
      else
        redirect to '/games'
      end
    else
      redirect '/'
    end
  end

  patch '/games/:id' do
    if logged_in?

      @game = Game.find_by_id(params[:id])
      image_file = @game.image

      if(params[:image])
        tempfile = params[:image][:tempfile] 
        filename = params[:image][:filename]
        timestamp = Time.now.to_i
        image_file = filename.gsub(".", "#{timestamp.to_s}.")
        cp(tempfile.path, "public/uploads/#{image_file}")
      end

      if @game.update(:name => params[:name], 
        :short_description => params[:short_description],
        :description => params[:description],
        :number_of_players => params[:number_of_players],
        :play_length => params[:play_length],
        :image => image_file,
        :featured => params[:featured] == "on" ? 1 : 0)
        redirect to "/games/#{@game.id}"
      else
        redirect to "/games/#{@game.id}/edit"
      end
    else
      redirect '/'
    end
  end

end
  