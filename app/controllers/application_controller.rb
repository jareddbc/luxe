class ApplicationController < ActionController::Base

  # protect_from_forgery with: :exception

  def current_user
    @current_user ||= Hotel.find(session[:hotel_id]) if session[:hotel_id]
  end
  helper_method :current_user

  def logged_in?
    current_user.present?
  end

  def authorize
    redirect_to '/login' unless current_user
  end

  def send_text_message(to, body)
    logger.info "SCHEDULING text message: #{to}, #{body}"
    SendTextMessageWorker.perform_async(to, body)
  end
end
