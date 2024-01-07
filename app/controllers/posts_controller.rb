class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create_image
    @title = params[:title]
    @taste = params[:taste]
    if @taste == "cute"
      response = @client.images.generate(
      parameters: { 
        model: "dall-e-3", 
        prompt: "アニメスタイルで#{@title}の可愛らしい円形のアイコン"
      }
    )
    elsif @taste =="cool"
      response = @client.images.generate(
      parameters: { 
        model: "dall-e-3", 
        prompt: "リアリティのある#{@title}のカッコいい円形のアイコン"
      }
    )
    end
    @icon_url = response.dig("data", 0, "url")
    @icon = ERB::Util.url_encode(@icon_url)
  end

  def index
    @posts = Post.all.includes(:user).order(created_at: :desc)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, success: t('defaults.message.created')
    else
      flash.now['danger'] = t('defaults.message.not_created')
      render :new
    end
  end

  def show
  end

  def destroy
  end

  private
    def post_params
      params.require(:post).permit(:title, :taste)
    end
end
