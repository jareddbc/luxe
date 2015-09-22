class GuestsController < ApplicationController
  include TwilioHelper

  def index
    redirect_to hotel_path
  end

  def new
    @guest = Guest.new
  end

  def create
    @guest = Guest.new(guest_params)
    @guest.key = @guest.last_name + @guest.phone[-4..-1]
    @guest.hotel = @hotel = Hotel.find(session[:hotel_id])
    if @guest.save
      send_text_message @guest.phone, render_to_string('greeting.text')
      redirect_to :back
    else
      render :new
    end
  end

  def show
    @guest = Guest.find(params[:id])
    @services = Service.where(hotel_id: @guest.hotel_id)
    @hotel = Hotel.find_by(id: @guest.hotel_id)
    @menus = Menu.where(hotel_id: @hotel.id)
  end

  def destroy
  end

  private

  def guest_params
    p params
    params.require(:guest).permit(:first_name, :last_name, :phone, :room_number)
  end



end
