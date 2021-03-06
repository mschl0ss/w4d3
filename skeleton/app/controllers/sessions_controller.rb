class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials( 
      params[:user][:user_name],
      params[:user][:password] 
      )

    if @user #we're not saving
      login!(@user)
      redirect_to cats_url
    else
      #some flash stuff
      render :new
    end
 
  end

  def destroy
    @current_user.reset_session_token if current_user
    session[:session_token] = nil
    @current_user = nil
    redirect_to new_session_url
  end 

end