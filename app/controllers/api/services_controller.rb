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
      p "#"*30
      event = get_service_event(@service, @guest, @hotel)
      p event
      create_calendar_event(event)
    	begin
        send_text_message @guest.phone, render_to_string('created_message.text')
      rescue => e
      	p "ERROR SENDING TEXT MESSAGE"
      	# p e
      end
    	render json:  {:error => nil, :service => @service}
    else
    	render json:  {:error => "Failed to create Service", :errors => @service.errors}
    end

  end

  # def show
  #   @service = Service.find_by(id: params[:id])
  # end

  # def update
  #   @guest = Guest.find(session[:guest_id])
  #   @service = Service.find(params[:id])
  #   @service.update_attributes(:title => params[:title], :starts_at_date => params[:starts_at_date], :starts_at_time => params[:starts_at_time], :special_request => params[:special_request])
  #   redirect_to @guest
  # end

  # def destroy
  #   @service = Service.find_by(id: params[:id])
  #   @service.destroy
  #   redirect_to :back
  # end

  private

  def service_params
    p params
    params.require(:service).permit(:title, :starts_at_date, :starts_at_time, :special_request)
  end

  # Creating object for Calendar Event


  def get_service_event(service, guest, hotel)
    event = {}
    event['summary'] = service.title

    event['location'] = hotel.address

    event['description'] = nil

    event['start'] = {'dateTime' => service.starts_at_time,
    'timeZone' => 'America/Los_Angeles'}

    event['end'] = {
      'dateTime' => service.starts_at_time,
      'timeZone' => 'America/Los_Angeles'}

    event['attendees'] = {'email' => guest.email}

    event['reminders'] = {
      'useDefault' => false,
      'overrides' => [
        {'method' => 'email', 'minutes' => 24 * 60},
        {'method' => 'popup', 'minutes' => 10},
      ],
     }
    p event
    p "$"*30
    render json: event
  end


end
