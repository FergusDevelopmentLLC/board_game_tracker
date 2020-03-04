class UsersController < ApplicationController

    get '/signup' do
      erb :'users/new'
    end
    
    post "/signup" do
        @user = User.new(params)
        if(!@user.valid?)
            erb :'users/new'
        else
            if @user.save
                session[:user_id] = @user.id
                redirect '/login'
            else
                redirect '/error'
            end
        end
    end
    
    get "/login" do
        erb :'users/login'
    end
    
    post "/login" do
        @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/"
        else
            redirect "/error"
        end
    end
    
    get "/logout" do
        session.clear
        redirect "/"
    end
end
  