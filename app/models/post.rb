class Post < ApplicationRecord
  belongs_to :user

	validates :title, presence: true, length: { maximum: 255 }
  validates :taste, presence: true, length: { maximum: 255 }

  has_one_attached :image
  
  def download_image(image_url)
    require 'open-uri'
    require 'fileutils'
    

    return unless image_url.present?

    file = URI.open(image_url)# URLから画像ファイルをダウンロードしたもの
      # ファイルのアップロード
    blob = ActiveStorage::Blob.create_and_upload!(
      io: file,
      filename: file.base_uri.to_s.split('/').last,
      content_type: 'image/png' # 適切なコンテンツタイプを設定
    )
    file.close
    blob.key #Blobのキーを返します。Active Storageでのファイル識別子
    rescue OpenURI::HTTPError => e
      # HTTPエラーが発生した場合の処理
      Rails.logger.error "画像のダウンロード中にHTTPエラーが発生しました: #{e.message}"
      nil

    rescue StandardError => e
      # その他のエラーが発生した場合の処理
      Rails.logger.error "画像のダウンロード中に予期せぬエラーが発生しました: #{e.message}"
      nil
  end
end
