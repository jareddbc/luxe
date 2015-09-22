class ApplicationController < ActionController::Base

  # protect_from_forgery with: :exception

  def current_user
    @current_user ||= Hotel.find(session[:hotel_id]) if session[:hotel_id]
  end
  helper_method :current_user

  def authorize
    redirect_to '/login' unless current_user
  end

  # def auth_token_txter
  #       @client.messages.create(
  #       from: '+18056284348',
  #       to: '+18188088325',
  #     body: 'Hey there!'
  #   )
  # end

  def send_text_message(to, body)
    SendTextMessageWorker.perform_async(to, body)
  end
end
