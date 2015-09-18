class SessionsController < ApplicationController
  def new
  end

  def create
    ###this is the working create method for just the hotel. I made the changes in the uncommented version underneath too, but only to the hotel code. I didn't touch the user stuff.


    # hotel = Hotel.find_by_email(params[:email])
    # if hotel && hotel.authenticate(params[:password])
    #   session[:hotel_id] = hotel.id
    #   redirect_to '/hotels/show', :notice => "Logged in!"
    # else
    #   flash.now.alert = "Invalid email or password"
    #   redirect_to '/login'


      hotel = Hotel.find_by_email(params[:email])
      user = User.authenticate(params[:key])
      if hotel && hotel.authenticate(params[:password])
        session[:hotel_id] = hotel.id
        redirect_to '/hotels/show', :notice => "Logged in!"
      elsif user
        session[:user_id] = user.key
        redirect_to root_url, :notice => "Logged in!"
      elsif
          flash.now.alert = "Invalid email or password"
          redirect_to '/login'
      elsif user
        flash.now.alert = "Invalid Key"
        render 'root'
      end

    end




    # if user
    #   session[user_id] = User.key
    # elsif
    #   flash.now.alert = "Invalid Key"
    #   render root
    # end

  def show
  end

  def destroy

    session[:hotel_id] = nil
    redirect_to '/login', :notice => "Logged out!"

  #   if user

  #   elsif hotel
  #     session[:hotel_id] = nil
  #     redirect_to root_url, :notice => "Logged out!"

  end

end
