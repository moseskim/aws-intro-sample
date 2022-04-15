class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [400, 400]

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # 업로드 파일 저장용 디렉터리는 덮어쓸 수 있다
  # 다음은 기본 저장 위치이다
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # 업로드 가능한 확장자 리스트
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
