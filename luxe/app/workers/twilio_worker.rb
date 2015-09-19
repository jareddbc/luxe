class TwilioWorker
  include Sidekiq::Worker
  def perform(twilio)
    auth_token_txter
  end
end
