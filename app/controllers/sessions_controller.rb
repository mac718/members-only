class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      sign_in(@user)
      redirect_to '/posts'
    else
      flash.now[:danger] = "Nope, try again!"
      render :new
    end
  end

  def destroy
    sign_out
  end
end
