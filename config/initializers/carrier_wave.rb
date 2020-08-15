if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Amazon S3用の設定
      :provider        => 'AWS',
      :region          => ENV['S3_REGION'],     # 例: 'ap-northeast-1'
      :use_iam_profile => true
    }
    config.fog_directory =  ENV['S3_BUCKET']
  end
end
