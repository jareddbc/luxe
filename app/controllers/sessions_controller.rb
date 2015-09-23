class SessionsController < ApplicationController
  def new
  end

  def create
     if params[:email] != nil
      hotel = Hotel.find_by_email(params[:email])
      if hotel && hotel.authenticate(params[:password])
        session[:hotel_id] = hotel.id
        redirect_to '/hotels/show', :notice => "Logged in!"
      else
          flash[:notice] = "Invalid email or password"
          redirect_to '/login'
      end
    elsif params[:key] != nil
      guest = Guest.find_by_key(params[:key])
      if guest
        session[:guest_id] = guest.id
        redirect_to guest_path id: session[:guest_id]
      else
          flash.now.alert = "Invalid Key"
          redirect_to '/'
      end
    end
  end

  def show
  end

  def destroy
    session[:hotel_id] = nil
    redirect_to '/login', :notice => "Logged out!"
  end

end
