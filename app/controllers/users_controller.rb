class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index,:edit,:update]
  before_action :correct_user, only: [:edit,:update]


  def index
    @users = User.all
    @discussions = @user.discussions
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome!"
      @user.update_attribute(:date_created, Date.today)
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def user_posts
    @user = User.find(params[:id])
    @discussions = @user.discussions
  end

  def user_replies
    @user = User.find(params[:id])
    @replies = Reply.all.where(:user_id => @user.id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def user_params
    params.require(:user).permit(:username, :date_created, :city, :email, :mobile_number, :password,
                                 :password_confirmation)
  end


  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end


  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end


end
