class PostsController < ApplicationController
  def index
    if params[:q].present?
      @posts = Post.entitled(params[:q])
    else
      @posts = Post.all
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end

  def search
    @posts = Post.entitled(params[:q])

    render 'index'
  end
  
  def create
    @post = Post.new(post_params)
    # Since the post will only save if it is valid, we can instead check if it saves to remove a line of code
    # if @post.valid?
    if @post.save
      redirect_to root_path
    else
      # Render this action's view again. 
      render :new
    end

    # Post.create({
    #   title: params[:post][:title],
    #   content: params[:post][:content],
    #   author: params[:post][:author],
    #   category: params[:post][:category]
    # })
    
  end


  # /posts/:id -> params[id]
  def edit
    @post = Post.find(params[:id])
  end

  def update 
    # REQUIRE ensures that there is a post
    # PERMIT allows these parameters to be altered, any that don't belong will be removed
    # can also move post_params to own method
    # post_params = params.require(:post).permit(:title, :author, :content, :category)
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def post_params
    params.require(:post).permit(:title, :author, :content, :category)
  end
  
  def new
    @post = Post.new
  end
  
  def 💩
    render text: 'poop'
  end
end
