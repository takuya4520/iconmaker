class ImagesController < ApplicationController
  def top; end

  def create_image
    @query = params[:query]
    @style = params[:style]
    if @style == "cute"
      response = @client.images.generate(
      parameters: { 
        model: "dall-e-3", 
        prompt: "アニメスタイルで#{@query}の可愛らしい円形のアイコン"
      }
    )
    elsif @style =="cool"
      response = @client.images.generate(
      parameters: { 
        model: "dall-e-3", 
        prompt: "リアリティのある#{@query}のカッコいい円形のアイコン"
      }
    )
    end
    @icon_url = response.dig("data", 0, "url")
    @icon = ERB::Util.url_encode(@icon_url)
  end
end
