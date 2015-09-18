class SessionsController < ApplicationController
  def new
  end

  def create
    hotel = Hotel.authenticate(params[:email], params[:password])
    user = User.authenticate(params[:key])
    if hotel
      session[:user_id] = hotel.id
      redirect_to root_url, :notice => "Logged in!"
    elsif user
      session[:user_id] = user.key
      redirect_to root_url, :notice => "Logged in!"
    else
      if hotel
        flash.now.alert = "Invalid email or password"
        render "new"
      elsif user
        flash.now.alert = "Invalid Key"
        render root
       end
    end
    # if hotel
    #   session[:user_id] = hotel.id
    #   redirect_to root_url, :notice => "Logged in!"
    # elsif
    #   flash.now.alert = "Invalid email or password"
    #   render "new"
    # end
    # if user
    #   session[user_id] = User.key
    # elsif
    #   flash.now.alert = "Invalid Key"
    #   render root
    # end

    # hotel = Hotel.authenticate(params[:email], params[:password])

  #   hotel = Hotel.authenticate(params[:email], params[:password])
  #   if hotel
  #     session[:user_id] = hotel.id
  #     redirect_to root_url, :notice => "Logged in!"
  #   else
  #     flash.now.alert = "Invalid email or password"
  #     render "new"
  #   end
  # end

  def destroy
    if user

    elsif hotel
      session[:hotel_id] = nil
      redirect_to root_url, :notice => "Logged out!"
  end

end
