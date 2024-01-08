class PostsController < ApplicationController
  before_action :set_post, only: %i[destroy]
  def index
    @posts = Post.all.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.taste == "cute"
      response = @client.images.generate(
      parameters: { 
        model: "dall-e-3", 
        prompt: "アニメスタイルで#{@post.title}の可愛らしい円形のアイコン"
      }
    )
    elsif @post.taste =="cool"
      response = @client.images.generate(
      parameters: { 
        model: "dall-e-3", 
        prompt: "リアリティのある#{@post.title}のカッコいい円形のアイコン"
      }
    )
    end
    @icon_url = response.dig("data", 0, "url")

    image_key = @post.download_image(@icon_url)
    @post.image.attach(ActiveStorage::Blob.find_by(key: image_key)) if image_key

    if @post.save
      redirect_to post_path(@post.id), success: t('defaults.message.created')
    else
      flash.now['danger'] = t('defaults.message.not_created')
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post.destroy!
    redirect_to posts_path
  end

  private
    def set_post
      @post = current_user.posts.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :taste, :image)
    end
end
