require 'aws-sdk-s3'

class ImageCompressor
  def self.optimize(key_num, width=640, height=640, resolution=80)
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
      image = MiniMagick::Image.read(image_file)
      image.resize("#{width}x#{height}")
      image.quality(resolution)
      # ⑤ content-typeを取得
      compressed_image = image
      type = file.content_type
      # ⑥ 既存のS3オブジェクトの画像をcompressed_imageに差し替える。
      s3 = Aws::S3::Resource.new(region: "ap-northeast-1")
      bucket = s3.bucket("blog-jt-bucket01")
      bucket.put_object(key: key_num, body: File.open(compressed_image.path), content_type: type)
    end
  end
end
