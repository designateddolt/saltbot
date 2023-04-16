require 'bunny'

def send_ruby(message)
	connection = Bunny.new(automatically_recover: false)
	connection.start

	channel = connection.create_channel
	queue = channel.queue('send_message') #change to constant

	channel.default_exchange.publish(message, routing_key: queue.name)
	puts "[ruby] Sent %s" % [message]

	connection.close
end