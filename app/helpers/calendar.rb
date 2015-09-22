# require 'google/api_client'
# require 'google/api_client/client_secrets'
# require 'google/api_client/auth/installed_app'
# require 'google/api_client/auth/storage'
# require 'google/api_client/auth/storages/file_store'
# require 'fileutils'

# APPLICATION_NAME = 'Google Calendar API Quickstart'
# CLIENT_SECRETS_PATH = 'client_secret.json'
# CREDENTIALS_PATH = File.join(Dir.home, '.credentials',
#                              "client_secret.json")
# SCOPE = 'https://www.googleapis.com/auth/calendar'

# ##
# # Ensure valid credentials, either by restoring from the saved credentials
# # files or intitiating an OAuth2 authorization request via InstalledAppFlow.
# # If authorization is required, the user's default browser will be launched
# # to approve the request.

# def authorize
#   FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

#   file_store = Google::APIClient::FileStore.new(CREDENTIALS_PATH)
#   storage = Google::APIClient::Storage.new(file_store)
#   auth = storage.authorize

#   if auth.nil? || (auth.expired? && auth.refresh_token.nil?)
#     app_info = Google::APIClient::ClientSecrets.load(CLIENT_SECRETS_PATH)
#     flow = Google::APIClient::InstalledAppFlow.new({
#       :client_id => app_info.client_id,
#       :client_secret => app_info.client_secret,
#       :scope => SCOPE})
#     auth = flow.authorize(storage)
#     puts "Credentials saved to #{CREDENTIALS_PATH}" unless auth.nil?
#   end
#   auth
# end

# # Initialize the API
# client = Google::APIClient.new(:application_name => APPLICATION_NAME)
# client.authorization = authorize
# calendar_api = client.discovered_api('calendar', 'v3')

# # Fetch the next 10 events for the user
# results = client.execute!(
#   :api_method => calendar_api.events.list,
#   :parameters => {
#     :calendarId => 'primary',
#     :maxResults => 10,
#     :singleEvents => true,
#     :orderBy => 'startTime',
#     :timeMin => Time.now.iso8601 })

# puts "Upcoming events:"
# puts "No upcoming events found" if results.data.items.empty?
# results.data.items.each do |event|
#   start = event.start.date || event.start.date_time
#   puts "- #{event.summary} (#{start})"
# end

#   # def event
#   #   render json: create_calendar_event(User.find(:id), Service.find(:id))
#   # end

#   # def create_calendar_event(user)
#   #   event = {}
#   #   event['summary'] = Service.title
#   #   event['location'] = Hotel.address
#   #   event['description'] = Service.special_request
#   #   event['start'] = {

#   #   }
#   #   event
#   # end
#   event = {
#   'summary' => 'Luxe Calendar',
#   'location' => '800 Howard St., San Francisco, CA 94103',
#   'description' => 'A chance to hear more about Google\'s developer products.',
#   'start' => {
#     'dateTime' => '2015-09-21T09:00:00-07:00',
#     'timeZone' => 'America/Los_Angeles',
#   },
#   'end' => {
#     'dateTime' => '2015-09-21T17:00:00-07:00',
#     'timeZone' => 'America/Los_Angeles',
#   },
#   'recurrence' => [
#     'RRULE:FREQ=DAILY;COUNT=2'
#   ],
#   'attendees' => [
#     {'email' => 'anuja.verma@gmail.com'}
#   ],
#   'reminders' => {
#     'useDefault' => false,
#     'overrides' => [
#       {'method' => 'email', 'minutes' => 24 * 60},
#       {'method' => 'popup', 'minutes' => 10},
#     ],
#   },
# }

# results = client.execute!(
#   :api_method => calendar_api.events.insert,
#   :parameters => {
#     # :calendarId => 'anuja.verma@gmail.com'},
#     :calendarId => 'luxeforluxary@gmail.com'},
#   :body_object => event)
# event = results.data
# puts "Event created"



# # https://developers.google.com/google-apps/calendar/quickstart/ruby
# # Change the scope to 'https://www.googleapis.com/auth/calendar' and delete any
# # stored credentials.

