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
      # TwilioWorker.perform(twilio)

    end
    p @guest
    redirect_to :back
  end

  def show
    @guest = Guest.find(params[:id])
    @services = Service.where(hotel_id: @guest.hotel_id)
    @menu = Menu.all
    #render :show, :layout => false
  end

  def destroy
  end

  private

  def guest_params
    p params
    params.require(:guest).permit(:first_name, :last_name, :phone, :room_number)
  end



end
