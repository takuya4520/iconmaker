class ImagesController < ApplicationController
  def top; end

  def create_image
    @query = params[:query]
    response = @client.images.generate(
      parameters: { 
        model: "dall-e-3", 
        prompt: "#{@query}の可愛らしいアイコン"
      }
    )
    @icon_url = response.dig("data", 0, "url")
  end
end
