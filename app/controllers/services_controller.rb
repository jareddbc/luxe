class ServicesController < ApplicationController
  def index
    redirect_to hotel_path
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @guest = Guest.find(session[:guest_id])
    @service.hotel = @hotel = @guest.hotel
    @service.guest = @guest
    if @service.save
      send_text_message @guest.phone, render_to_string('created_message.text')
      redirect_to :back
    else
      raise "FAILED TO CREATE SERVICE"
    end
  end

  def show
    @service = Service.find_by(id: params[:id])
  end

  def edit
    @service = Service.find(params[:id])
  end

  def update
    @guest = Guest.find(session[:guest_id])
    @service = Service.find(params[:id])
    @service.update_attributes(:title => params[:title], :starts_at_date => params[:starts_at_date], :starts_at_time => params[:starts_at_time], :special_request => params[:special_request])
    redirect_to @guest
  end

  def destroy
    @service = Service.find_by(id: params[:id])
    @service.destroy
    redirect_to :back
  end

  private

  def service_params
    p params
    params.require(:service).permit(:title, :starts_at_date, :starts_at_time, :special_request)
  end
end
