require 'google/api_client'


class Calendar

  GOOGLE_EMAIL = ENV['GOOGLE_EMAIL']
  CLIENT_EMAIL = ENV['GOOGLE_CLIENT_EMAIL']

  class << self

    def client
      @client ||= connect!
    end

    def calendar_api
      @calendar_api ||= client.discovered_api('calendar', 'v3')
    end

    def connect!
      @client = Google::APIClient.new(:application_name => 'LUXE', :application_version => '1')
      puts "CONNECT!"
      puts GoogleCalendarKey.get
      #key = Google::APIClient::PKCS12.load_key(GoogleCalendarKey.get, 'notasecret')
      #key = Google::APIClient::PKCS12.load_key( ENV['GOOGLE_CALENDAR_KEY_DECODED'], 'notasecret')
      key = OpenSSL::PKey::RSA.new ENV["GOOGLE_CALENDAR_KEY_DECODED"], 'notasecret'
      puts "CONNECT2"
      p key
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
        new(calendar.id, calendar)
      end
    end

    def create(summary)
      response = client.execute!(
        :api_method => calendar_api.calendars.insert,
        :body => JSON.dump({:summary => summary}),
        :headers => {'Content-Type' => 'application/json'}
      )

      raise "failed to create calendar: #{response.error_message}" unless response.success?

      calendar = new(response.data.id, response.data)
      calendar.grant_public_read_access!
      calendar.create_inital_event!
      calendar
    end

    def get(id)
      response = client.execute(
        :api_method => calendar_api.calendar_list.get,
        :parameters => {'calendarId' => id},
      )
      response.success? ? new(response.data.id, response.data) : nil
    end

  end

  attr_reader :id

  def initialize(id, data=nil)
    @id = id
    @data = data
  end

  delegate :client, :calendar_api, to: :class

  def data
    @data ||= begin
      raise "LOADING CALENDAR DATA NOT IMPLEMENTED YET"
    end
  end

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

  def create_calendar_event(event)
    response = client.execute!(
      :api_method => calendar_api.events.insert,
      :parameters => {:calendarId => id},
      :body_object => event
    )
    response.success?
  end

  def create_inital_event!
    create_calendar_event(
      'summary' => "Calendar created",
      'description' => 'Your LUXE calendar was created',
      'start' => {
        'dateTime' => DateTime.now.rfc3339(9),
        'timeZone' => 'America/Los_Angeles',
      },
      'end' => {
        'dateTime' => DateTime.now.rfc3339(9),
        'timeZone' => 'America/Los_Angeles',
      },
    ) or raise "Failed to create initial event for calendar #{id}"
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

    raise "failed to grant public reader access to calendar #{id}: #{response.error_message}" unless response.success?

    self
  end

  module GoogleCalendarKey
    def self.get
      Base64.decode64 ENV['GOOGLE_CALENDAR_KEY']
    end
  end


end

