class Api::ServicesController < ApplicationController
	before_filter do
    puts "BEFORE FILTER"
    p session[:guest_id]
    unless session[:guest_id]
      puts "RENDERING ERROR"
    	render json:  {:error => "Not Logged In"}
    end
	end

  def create
    @service = Service.new(service_params)
    @guest = Guest.find(session[:guest_id])
    @service.hotel = @hotel = @guest.hotel
    @service.guest = @guest
    if @service.save
    	begin
        send_text_message @guest.phone, render_to_string('created_message.text')
      rescue => e
      	p "ERROR SENDING TEXT MESSAGE"

      end
    	render json:  {:error => nil, :service => @service}
    else
    	render json:  {:error => "Failed to create Service", :errors => @service.errors}
    end

  end

  private
  def service_params
    p params
    params.require(:service).permit(:title, :starts_at_date, :starts_at_time, :special_request)
  end
end
