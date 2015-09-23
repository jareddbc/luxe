require 'google/api_client'
# require 'date'


class Calendar

  # MOVE ME TO .env
  GOOGLE_EMAIL = ENV['GOOGLE_EMAIL']
  CLIENT_EMAIL = JSON.parse(Rails.root.join('config/google_calendar_key.json').read)['client_email']
  # CLIENT_EMAIL = id
  class << self

    def client
      @client ||= connect!
    end

    def calendar_api
      @calendar_api ||= client.discovered_api('calendar', 'v3')
    end

    def connect!
      @client = Google::APIClient.new(:application_name => 'LUXE', :application_version => '1')
      key_file_path = Rails.root.join('config','google_calendar_key.p12').to_s
      key = Google::APIClient::PKCS12.load_key(key_file_path, 'notasecret')
      service_account = Google::APIClient::JWTAsserter.new(
        CLIENT_EMAIL,
        ['https://www.googleapis.com/auth/calendar'],
        key
      )
      @client.authorization = service_account.authorize(CLIENT_EMAIL)

      @client
    end

    def all
      response = client.execute(:api_method => calendar_api.calendar_list.list)
      response.data.items.map do |calendar|
        new(calendar.id)
      end
    end

    def create(summary)
      response = client.execute!(
        :api_method => calendar_api.calendars.insert,
        :body => JSON.dump({:summary => summary}),
        :headers => {'Content-Type' => 'application/json'}
      )

      raise "failed to create calendar: #{response.error_message}" unless response.success?

      new(response.data.id).grant_public_read_access!

    end

    def get(id)
      response = client.execute(
        :api_method => calendar_api.calendar_list.get,
        :parameters => {'calendarId' => id},
      )
      response.success? ? new(response.data.id) : nil
    end

  end

  attr_reader :id

  def initialize(id)
    @id = id
  end

  delegate :client, :calendar_api, to: :class

  def primary?
    id == GOOGLE_EMAIL
  end

  def destroy!
    if primary?
      warn 'refusing to delete primary calendar'
      return
    end
    response = client.execute(
      api_method: calendar_api.calendars.delete,
      parameters: {'calendarId' => id},
    )
    response.success?
  end

  def get_events
    response = client.execute!(
      :api_method => calendar_api.events.list,
      :parameters => {
        :calendarId => id,
        :maxResults => 10,
        :singleEvents => true,
        :orderBy => 'startTime',
        :timeMin => Time.now.iso8601,
      },
    )
    if response.success?
      return response.data.items
    else
      throw "failed to load events for calendar #{id}: #{response.error_message}"
    end
  end

  def create_event
    event = {
      'summary' => 'something',
      'location' => '800 Howard St., San Francisco, CA 94103',
      'description' => 'OMG what',
      'start' => {
        'dateTime' => '2015-10-10T09:00:00-07:00',
        'timeZone' => 'America/Los_Angeles',
      },
      'end' => {
        'dateTime' => '2015-10-10T17:00:00-07:00',
        'timeZone' => 'America/Los_Angeles',
      },
      'recurrence' => [
        'RRULE:FREQ=DAILY;COUNT=1'
      ],
      'attendees' => [
        {'email' => 'lpage@example.com'},
        {'email' => 'sbrin@example.com'},
      ],
      'reminders' => {
        'useDefault' => false,
        'overrides' => [
          {'method' => 'email', 'minutes' => 24 * 60},
          {'method' => 'popup', 'minutes' => 10},
        ],
      },
    }

    client.execute!(
      :api_method => calendar_api.events.insert,
      :parameters => {:calendarId => id},
      :body_object => event
    )
  end


  def grant_public_read_access!
    rule = {
      'scope' => {'type' => 'default' },
      'role' => 'reader'
    }
    response = client.execute(
      api_method: calendar_api.acl.insert,
      parameters: {'calendarId' => id},
      headers:    {'Content-Type' => 'application/json'},
      body:       JSON.dump(rule),
    )

    raise "failed to grand public reader access to calendar #{id}: #{response.error_message}" unless response.success?

    self
  end


end

