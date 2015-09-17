class SessionsController < ApplicationController
  def new
  end

  def create
    hotel = Hotel.authenticate(params[:email], params[:password])
    if hotel
      session[:user_id] = hotel.id
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:hotel_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

end
