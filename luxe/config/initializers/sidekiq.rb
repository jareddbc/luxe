app_name = Rails.application.class.parent_name

Sidekiq.configure_server do |config|
  config.redis = {url: "redis://localhost:6379/0", namespace: "#{app_name}"}
end

Sidekiq.configure_client do |config|
  config.redis = {url: "redis://localhost:6379/0", namespace: "#{app_name}"}
end
