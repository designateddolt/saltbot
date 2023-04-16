import pika

def send_python(message):
    connection = pika.BlockingConnection(
        pika.ConnectionParameters(host='localhost'))
    channel = connection.channel()

    channel.queue_declare(queue='receive_message') #change

    channel.basic_publish(exchange='', routing_key='receive_message', body=message)
    print(" [x] Sent {}".format(message))
    connection.close()