class UsersController < ApplicationController
  def index
  end

  def login_form
  end

  def login
    @user = User.find_by(emal: params[:email], password: params[:password])
    if @user
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
    else
      render("users/login_form")
    end
  end
end
