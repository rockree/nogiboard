class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find_by(id: params[:id])
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
  def new
  end

  def create
    @user = User.new(name: params[:name], email: params[:email])
    @user.save
    redirect_to("/users/#{@user.id}")

  end
end
