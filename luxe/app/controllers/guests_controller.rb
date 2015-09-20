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
    if @guest.save
      @guest.key = @guest.last_name + @guest.phone[-4..-1]
      @guest.hotel_id = session[:hotel_id]
      @guest.save
      @client
      @users_hotel_id = @guest.hotel_id
      @hotel = Hotel.find_by(params[:hotel_id])
      "@@" * 88
      phone_twilio = @guest.phone
      name_twilio = @guest.first_name
      hotel_name_twilio = @hotel.name
      key_twilio = @guest.key

      TwilioWorker.perform_async(phone_twilio, name_twilio, hotel_name_twilio, key_twilio)
    end
    p @guest
    redirect_to :back
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
