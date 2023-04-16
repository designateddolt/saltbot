require 'bunny'

def get_ruby()
  connection = Bunny.new(automatically_recover: false)
  connection.start

  channel = connection.create_channel
  queue = channel.queue('receive_message') #change

  result = "nothing recieved!"
  begin
    puts ' [ruby] Waiting for messages. To exit press CTRL+C'
    # block: true is only used to keep the main thread
    # alive. Please avoid using it in real world applications.
    queue.subscribe(block: true) do |_delivery_info, _properties, body|
      puts " [ruby] Received #{body}"
      result = body
      connection.close
  end
  rescue Interrupt => _
    connection.close
  end

  return result
end