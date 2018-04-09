class UsersController < ApplicationController
  def index
    @users = User.all()
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
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "default_user.jpg"
    )

    if @user.save
    redirect_to("/users/#{@user.id}")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}",image.read)
    end

    if @user.save
      flash[:notice]="ユーザー情報を変更しました"
      redirect_to("/users/#{@user.id}")
    else
      render("/users/#{@user.id}")
    end
  end

end
