SidekiqInit = proc do
  app_name = Rails.application.class.parent_name

  Sidekiq.configure_server do |config|
    config.redis = {url: Rails.configuration.redis, namespace: "#{app_name}"}
  end

  Sidekiq.configure_client do |config|
    config.redis = {url: Rails.configuration.redis, namespace: "#{app_name}"}
  end
end
