class UsersController < ApplicationController
  def new 
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      sign_in @user
      flash[:success] = "You've successfully signed up!"
      redirect_to posts_path
    else 
      render :new
    end
  end

  def edit
  end

  def destroy
  end

  private 
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
