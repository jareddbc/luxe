class PostCreateServiceWorker
  include Sidekiq::Worker

  def perform(id)
    service = Service.find(id)
    hotel = service.hotel
    guest = service.guest
    create_service_calendar_event(service, hotel, guest)
    send_text_message(service, hotel, guest)
  end


  def send_text_message(service, hotel, guest)
body = """
Hello #{guest.first_name},
We just scheduled a service: #{service.title} for you.
Thank you for staying at the #{hotel.name}, please login here: goo.gl/V3VkvX
and input this Guest Token: #{guest.key}
to start living LUXE.
Have a great stay!
"""
    SendTextMessageWorker.perform_async(guest.phone, body)
  end

  def create_service_calendar_event(service, hotel, guest)
    p "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    p hotel.id
    startTime = service.starts_at_date
    endTime = startTime + 1.hour
    hotel.calendar.create_calendar_event(
      'summary' => "#{service.title}",
      'description' => "#{service.title} at #{hotel.name}",
      'location' => "#{hotel.name} #{hotel.address}",
      'start' => {
        'dateTime' => startTime.to_datetime.rfc3339(9),
        'timeZone' => 'America/Los_Angeles',
      },
      'end' => {
        'dateTime' => endTime.to_datetime.rfc3339(9),
        'timeZone' => 'America/Los_Angeles',
      },
      'attendees' => [
        {email: guest.email}
      ],
    ) or raise "failed to create service event for service #{service.id}"
  end

end

