class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user
      login!
      redirect_to user_url(@user)
    else
      @user = User.new(username: params[:user][:username])
      
      flash.now[:errors] = ['Invalid Username/Password Combination']
      render :new
    end
  end

  def destroy
    @user = User.find_by_session_token(session[:session_token])
    @user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
