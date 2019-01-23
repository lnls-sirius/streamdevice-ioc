#!/usr/bin/python3
import argparse
import logging
import socket
import struct
import select
import os
import time

# from serial import Serial
def tcp_client(ip, data):
    pass
if __name__ == '__main__':

    parser = argparse.ArgumentParser(
        "UNIX - TCP socket bind.\n" +
        "A bridge between an UNIX socket and a TCP server.\n" +
        "If a zero bytes response is expected from the other side of the connection, \n" +
        "one must send an encoded string matching --reconnect-interval \n" + 
        "so that the TCP client doesn't block indefinitely.\n\n"
    )
    parser.add_argument("--socket-buffer","-sb", default=1024,type=int, help='Socket recv buffer.', dest="socket_buffer")
    parser.add_argument("--socket-path","-sp", default='/var/tmp/sock_test.s', help='Unix socket path.', dest="socket_path")
    parser.add_argument("--port","-p", default=4161,type=int, help='TCP Server port.', dest="port")
    parser.add_argument("--address","-addr", default='0.0.0.0', help='TCP Server address.', dest="address")
    parser.add_argument("--zero-bytes","-zb", default='ZB', help='What to return when a zero lengh response is returned from the serial port. Default \'ZB\'.encode(\'utf-8\')', dest="zero_bytes")
    parser.add_argument("--reconnect-interval", default=5, type=int, help='TCP Server reconnect interval.', dest="reconnect_interval")
    args = parser.parse_args()
    zb = args.zero_bytes.encode('utf-8')

    logging.basicConfig(level=logging.INFO,
                        format='%(asctime)-15s [%(levelname)s] %(message)s',
                        datefmt='%d/%m/%Y %H:%M:%S')
    logger = logging.getLogger()

    logger.info('Unix %s <-> TCP %s:%s buffer %s' %(args.socket_path, args.address, args.port, args.socket_buffer))

    server_address = (args.address, args.port)
    connected_to_server = False

    while True:
        if os.path.exists(args.socket_path):
            os.remove(args.socket_path)

        with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
            s.bind(args.socket_path)
            s.listen()
            logger.info('Unix Socket: Waiting for a connection ...')
            conn, addr = s.accept()
            try:
                with conn:
                    logger.info('Connected {} {}'.format(conn, addr))
                    while True:
                        data = conn.recv(args.socket_buffer)

                        if not data:
                            logger.info('No data received ... ')
                            break

                        if not connected_to_server:
                            try:
                                # Create a TCP/IP socket
                                tcp_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                                logger.info('Connecting to %s port %s' % server_address)
                                tcp_socket.connect(server_address)
                                connected_to_server = True
                            except ConnectionRefusedError:
                                logger.exception('Conn refused ... !')
                                time.sleep(args.reconnect_interval)
                                continue

                        try:
                            # Send data to server
                            tcp_socket.sendall(data)

                            # logger.info('Waiting a response ...')
                            res = tcp_socket.recv(1024)
                            if res and res != zb:
                                #logger.info('Out %s In %s' % (data, res))
                                conn.sendall(res)

                        except Exception as e:
                            connected_to_server = False
                            logger.exception('Error? ... %s' % e)

            except ConnectionError:
                logger.exception('Connection Error !')
