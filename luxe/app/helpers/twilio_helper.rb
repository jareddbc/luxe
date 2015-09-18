module TwilioHelper
  p account_sid = ENV["ACCOUNT_SID"]
  p auth_token = ENV["AUTH_TOKEN"]

  @client = Twilio::REST::Client.new  account_sid, auth_token
end

