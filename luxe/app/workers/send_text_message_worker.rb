class SendTextMessageWorker
  include Sidekiq::Worker

  ACCOUNT_SID = ENV["ACCOUNT_SID"]
  AUTH_TOKEN  = ENV["AUTH_TOKEN"]

  def perform(to, body)
    client.messages.create(
      from: '+12254429126',
      to: "+1#{to}",
      body: body,
    )
  end

  def client
    @client ||= Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
  end

end
