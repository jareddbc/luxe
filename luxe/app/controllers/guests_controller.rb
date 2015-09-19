class GuestsController < ApplicationController
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
    end
    p @guest
    redirect_to :back
  end

  def show
    @guest = Guest.find_by(key: params[:key])
  end

  def destroy
  end

  private

  def guest_params
    p params
    params.require(:guest).permit(:first_name, :last_name, :phone, :room_number)
  end



end
