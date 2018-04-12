class PostsController < ApplicationController
  def index
    @posts = Post.all()
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
  end

  def new
  end

  def create
    @post = Post.new(
      user_id: session[:user_id],
      content: params[:content],
      image_name: "default-user.jpg"
    )

    if params[:image]
      @post.image_name = "#{@post.id}.jpg"
      image = params[:image]
      File.binwrite("public/post_images/#{@post.image_name}",image.read)
    end

    if @post.save
      flash[:notice]="投稿情報を変更しました"
      redirect_to("/posts/index")
    else
      render("/posts/new")
    end

  end


  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    @post.save
    redirect_to("/posts/index")
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/posts/index")
  end

end
