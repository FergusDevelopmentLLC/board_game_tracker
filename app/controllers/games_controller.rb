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
              redirect '/'
          else
              redirect '/error'
          end
      end
  end

end
  