class ApplicationController < ActionController::Base
  helper_method :current_user

private

  def current_user
    @current_user ||= Hotel.find(session[:hotel_id]) if session[:hotel_id]
  end
    # protect_from_forgery with: :exception
end
