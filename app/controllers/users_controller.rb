class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create, :login, :deletAll, :delete_user]
     helper_method :current_user, :logged_in?
   
   
    def create
      @user=User.new(user_params)
      if @user.save
        render json: {message: "User registered successfully", status: :ok}
    else
        render json: { errors: @user.errors.full_messages, status: :unprocessable_entity }
      end
    end
   
   
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :email, :firstname, :lastname)
    end
   
   
   
   
    def login
      user = User.find_by(username: params[:username])
   
   
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        render json: {id: user.id}, status: :ok
      else
        render json: {error: "Invalid Username or Password"},status: :bad_request
      end
    end
   
   
   
   
    def get_user
    
        @current_user ||= User.find_by(id: session[:user_id])  
   
   
      if @current_user.nil?
        render json: {error: "Unauthorized", message: "you are not logged in"},status: :bad_request
   
   
        else
          if session[:user_id]== params[:id].to_i
            user = User.find_by(id: params[:id].to_i)
            render json: user
             
            else
                render json: {error: "Unauthorized", message: "you are not authorized user"},status: :bad_request
          end
      end 
    end
   
   
    def delete_user
      @current_user ||= User.find_by(id: session[:user_id])  
   
   
      if @current_user.nil?
        render json: {error: "Unauthorized", message: "you are not logged in"},status: :bad_request
   
   
        else
          if session[:user_id]== params[:id].to_i
            user = User.find_by(id: params[:id].to_i).destroy
           
            # redirect_to "/user/login"
   
   
            else
                render json: {error: "Unauthorized", message: "you canot delete other user details"},status: :bad_request
          end
      end 
    end
   
   
    def allUser
      page_number = params[:page] || 1
      @users = User.paginate(page: page_number, per_page: 3)
        if @users
          render json: @users
        end
    end 
end
