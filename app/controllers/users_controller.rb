class UsersController < ApplicationController
  before_action :require_logged_in, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @other_goals = Goal.public_goals.where.not(user_id: @user.id)
    @users_public_goals = @user.goals.where(privacy: 'public')
    render :show
  end

  private

  def require_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
