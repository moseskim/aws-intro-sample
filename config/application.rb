require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SampleApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.time_zone = 'Seoul' # 애플리케이션의 타임존
    config.active_record.default_timezone = :local #데이터베이스의 타임존

    # 인증 토큰을 remote 폼에 삽입
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
