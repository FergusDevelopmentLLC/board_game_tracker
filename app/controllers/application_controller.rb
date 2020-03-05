class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secure_password'
  end

  get '/' do
    erb :index
  end

  get '/error' do
    erb :error
  end

  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
    end
    
    def generate_code(number)
      charset = Array('a'..'z')
      Array.new(number) { charset.sample }.join
    end

	end
  
end
