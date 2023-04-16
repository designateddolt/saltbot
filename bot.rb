# frozen_string_literal: true

# This simple bot responds to every "Ping!" message with a "Pong!"

require 'discordrb'
require 'json'
require_relative 'mq_get_ruby'
require_relative 'mq_send_ruby'
require_relative 'config'

# This statement creates a bot with the specified token and application ID. After this line, you can add events to the
# created bot, and eventually run it.
#
# If you don't yet have a token to put in here, you will need to create a bot account here:
#   https://discord.com/developers/applications
# If you're wondering about what redirect URIs and RPC origins, you can ignore those for now. If that doesn't satisfy
# you, look here: https://github.com/discordrb/discordrb/wiki/Redirect-URIs-and-RPC-origins
# After creating the bot, simply copy the token (*not* the OAuth2 secret) and put it into the
# respective place.
bot = Discordrb::Bot.new token: Config::DISCORD_TOKEN

# Here we output the invite URL to the console so the bot account can be invited to the channel. This only has to be
# done once, afterwards, you can remove this part if you want

# This method call adds an event handler that will be called on any message that exactly contains the string "Ping!".
# The code inside it will be executed, and a "Pong!" response will be sent to the channel.
bot.message do |event|
  #if event.user.id == 366135415381557250 then
  send_ruby(event.message.to_s)
  result = JSON.parse(get_ruby)
  response = "Your message is %.0f%% negative, %.0f%% neutral and %.0f%% positive!" % [result["neg"].to_f*100, result["neu"].to_f*100, result["pos"].to_f*100]
  event.respond response
    ##puts event.message
  #end
end

# This method call has to be put at the end of your script, it is what makes the bot actually connect to Discord. If you
# leave it out (try it!) the script will simply stop and the bot will not appear online.
bot.run