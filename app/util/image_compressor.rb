require 'aws-sdk-s3'

class ImageCompressor
  def self.optimize(key_num, width=640, height=640)
    # ① clientの作成
    s3_client = Aws::S3::Client.new(
      region: "ap-northeast-1",
      access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
      secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key)
    )
    # ② オブジェクトの取得
    file = s3_client.get_object(bucket: "blog-jt-bucket01", key: key_num)

    if file.content_type.match?(/image/)
      # ④ 画像のリサイズ・圧縮
      image_file = file.body.read
      # image = Magick::ImageList.new("https://blog-jt-bucket01.s3.ap-northeast-1.amazonaws.com/uploads/tmp/1633870275-336983723201947-0027-3329/IMG_7034.JPG").first
      image = MiniMagick::Image.read(image_file)
      # image.resize("640x640")
      image.resize("#{width}x#{height}")
      # ⑤ content-typeを取得
      compressed_image = image
      type = file.content_type
      # ⑥ 既存のS3オブジェクトの画像をcompressed_imageに差し替える。
      s3 = Aws::S3::Resource.new(
        region: "ap-northeast-1",
        access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
        secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key)
      )
      bucket = s3.bucket("blog-jt-bucket01")
      bucket.object(key_num).upload_file(File.open(compressed_image.path), content_type: type)
    end
  end
end
