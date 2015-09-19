class HotelsController < ApplicationController

  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = Hotel.new(hotel_params)
    if @hotel.save
      session[:hotel_id] = @hotel.id
      redirect_to '/login', :notice => "Signed up!"
    else
      redirect_to signup_path
    end
  end

  def index
  end

  def show
    @hotel = Hotel.find_by(id: session[:hotel_id])
  end

  def edit
  end

  def destroy
    # sessions[:hotel_id] = nil
    # p sessions[:hotel_id]
    redirect_to '/login', :notice => "Logged out!"
  end

private

  def hotel_params
    params.require(:hotel).permit(:name, :email, :password, :password_confirmation, :amenities, :location)
  end

end
