# SaltBot - discordrb bot made to play around with message queuing and other stuff

## Running the bot
Write your own top-level `config.rb` file containing a class `Config` that has a property `DISCORD_TOKEN`, which has the value of your bot token from discord.

You'll need to have two consoles open - one on which to run `ruby bot.rb` and one on which to run `python mq_get_python.py`
