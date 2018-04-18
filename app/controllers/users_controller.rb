class UsersController < ApplicationController

  before_action :ensure_correct_user, {only: [:edit, :update]}

  def index
    @users = User.all()
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def login_form
  end

  def login
    encrypted_password = OpenSSL::Digest::SHA256.hexdigest(params[:password])
    @user = User.find_by(email: params[:email], password: encrypted_password)
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/users/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  def new
  end

  def create
    password = params[:password]
    encrypted_password = (OpenSSL::Digest::SHA256).hexdigest(password)

    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "default_user.jpg",
      password: encrypted_password
    )

    if @user.save
      session[:user_id] = @user.id
      redirect_to("/users/#{@user.id}")
      NoticeMailer.sendmail_confirm(@user).deliver
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

  def destroy
    session[:user_id] = nil
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to("/login")
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  def posts
    return @user.posts(self.id)
    
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id:[@user.id])
  end

end
