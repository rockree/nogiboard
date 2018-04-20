class PostsController < ApplicationController
  def index
    page = params[:page] #12345567...,nil

    if page == nil
       page = 1
    end

    @page = page.to_i #to_iは、文字列を受けとってコピーして整数にして返す。非破壊的メソッド

    @page_num = 5#１ページに表示したいやつ
    @record_count = Post.where("id > 0").count
    @posts = Post.all.order(created_at: :desc).limit(@page_num).offset((@page-1) * @page_num)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
  end

  def new
  end

  def create

    @post = @current_user.posts.new(content: params[:content])
    #これと同じ☝️@post = Post.new(user_id: session[:user_id],content: params[:content],)

    if @post.save
      flash[:notice]="投稿しました"
      redirect_to("/posts/index")
    else
      render("/posts/new")
    end

    if params[:image]
      @post.image_name = "#{@post.id}.jpg"
      image = params[:image]
      File.binwrite("public/post_images/#{@post.image_name}",image.read)
      @post.save
    end



  end


  def edit
    @post = Post.find_by(id: params[:id])
  end


  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]

    if @post.save
      flash[:notice]="編集しました"
      redirect_to("/posts/index")

    else
      render("/posts/edit")
    end
  end


  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy

    redirect_to("/posts/index")
  end

end
