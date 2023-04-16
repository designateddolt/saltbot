import pika, sys, os
from sentiment import analyse
from mq_send_python import send_python

def main():
    connection = pika.BlockingConnection(pika.ConnectionParameters(host='localhost'))
    channel = connection.channel()

    channel.queue_declare(queue='send_message') #change to constant

    def callback(ch, method, properties, body):
        print("[python] Received %r" % body.decode())
        sentiment_analysis = analyse(body.decode())
        send_python(sentiment_analysis)

    channel.basic_consume(queue='send_message', on_message_callback=callback, auto_ack=True)

    print(' [python] Waiting for messages. To exit press CTRL+C')
    channel.start_consuming()

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print('Interrupted')
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)