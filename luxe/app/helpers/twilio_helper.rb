module TwilioHelper
  account_sid = ENV["ACCOUNT_SID"]
  auth_token = ENV["AUTH_TOKEN"]

  $client = Twilio::REST::Client.new account_sid, auth_token
  p "3" * 33
  p $client

  def auth_token_txter
        $client.messages.create(
        from: '+12254429126',
        to: '+18188088325',
        body: "Thank you for staying at the #{@hotel.name}, please login here: goo.gl/V3VkvX \n and input this Guest Token: #{@guest.key} \n to start living LUXE. \n Have a great stay!"
    )
  end
end

