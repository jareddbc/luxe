class ServicesController < ApplicationController
  def index
    redirect_to hotel_path
  end

  def new
    @service = Service.new
  end

  def create
    p "#"*30
    @service = Service.new(service_params)
    @guest = Guest.find(session[:guest_id])
    @service.hotel = @hotel = @guest.hotel
    @service.guest = @guest
      p "#"*30
      event = get_service_event(@service, @guest, @hotel)
      p event
      create_calendar_event(event)

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
    params.require(:service).permit(:title, :starts_at_date, :starts_at_time)
  end
end

# # Creating object for Calendar Event


#   def get_service_event(service, guest, hotel)
#     event = {}
#     event['summary'] = service.title

#     event['location'] = hotel.address

#     event['description'] = nil

#     event['start'] = {'dateTime' => service.starts_at_time,
#     'timeZone' => 'America/Los_Angeles'}

#     event['end'] = {
#       'dateTime' => service.starts_at_time,
#       'timeZone' => 'America/Los_Angeles'}

#     event['attendees'] = {'email' => guest.email}

#     event['reminders'] = {
#       'useDefault' => false,
#       'overrides' => [
#         {'method' => 'email', 'minutes' => 24 * 60},
#         {'method' => 'popup', 'minutes' => 10},
#       ],
#      }
#     p event
#     p "$"*30
#     render json: event
#   end

end
