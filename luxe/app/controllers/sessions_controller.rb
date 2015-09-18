class SessionsController < ApplicationController
  def new
  end

  def create
    hotel = Hotel.find_by_email(params[:email])
    if hotel && hotel.authenticate(params[:password])
      session[:hotel_id] = hotel.id
      redirect_to '/hotels/show', :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      redirect_to '/login'
    end
  end

  def show
  end

  def destroy
    session[:hotel_id] = nil
    redirect_to '/login', :notice => "Logged out!"
  end

end
