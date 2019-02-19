#!/usr/bin/python3
import argparse
import logging
import socket
import struct
import select
import os
import time
import threading

from concurrent.futures import ThreadPoolExecutor

logging.basicConfig(level=logging.INFO,
                    format='%(asctime)-15s [%(levelname)s] %(message)s',
                    datefmt='%d/%m/%Y %H:%M:%S')
logger = logging.getLogger()

class TcpUnixBind():

    def __init__(self, socket_path, address, socket_buffer, zero_bytes, reconnect_interval, **kwargs):
        self.socket_path = socket_path
        self.address = address.split(':')[0]

        try:
            self.port = int(address.split(':')[1])
        except:
            self.port = 4161

        self.socket_buffer = socket_buffer
        self.zero_bytes = 'ZB'.encode('utf-8') if zero_bytes == None else zero_bytes.encode('utf-8')
        self.reconnect_interval = reconnect_interval
        self.connected_to_server = False

    def __str__(self):
        return '<TcpUnixBind UNIX Socket {} TCP Socket {} reconnect interval {} General zero-bytes {} buffer {}>'\
            .format(self.socket_path, self.address, self.reconnect_interval, self.zero_bytes, self.socket_buffer)

    def start(self):
        logger.info('Starting Unix <-> TCP {}'.format(self))

        server_address = (self.address, self.port)

        while True:
            if os.path.exists(self.socket_path):
                os.remove(self.socket_path)

            with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
                s.bind(self.socket_path)
                s.listen()
                logger.info('Unix Socket {}: Waiting for a connection ...'.format(self.socket_path))
                conn, addr = s.accept()
                try:
                    with conn:
                        logger.info('Connected {} {}'.format(conn, addr))
                        while True:
                            data = conn.recv(self.socket_buffer)

                            if not data:
                                logger.info('No data received ... ')
                                break

                            if not self.connected_to_server:
                                try:
                                    # Create a TCP/IP socket
                                    tcp_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                                    logger.info('Connecting to {}'.format(server_address))
                                    tcp_socket.connect(server_address)
                                    self.connected_to_server = True
                                except ConnectionRefusedError:
                                    logger.error('Conn refused ... ! {}'.format(server_address))
                                    time.sleep(self.reconnect_interval)
                                    continue

                            try:
                                # Send data to server
                                tcp_socket.sendall(data)
                                res = tcp_socket.recv(1024)
                                if res:
                                    if res != self.zero_bytes:
                                        conn.sendall(res)
                                    elif res.startswith(self.zero_bytes):
                                        conn.sendall(res[len(self.zero_bytes):])
                            except:
                                self.connected_to_server = False
                                logger.exception('Error? ...')

                except ConnectionError:
                    logger.exception('Connection Error !')



if __name__ == '__main__':

    parser = argparse.ArgumentParser(
        "UNIX - TCP socket bind.\n" +
        "A bridge between an UNIX socket and a TCP server.\n" +
        "If a zero bytes response is expected from the other side of the connection, \n" +
        "one must send an encoded string matching --reconnect-interval \n" +
        "so that the TCP client doesn't block indefinitely.\n\n")

    parser.add_argument("--socket-buffer","-sb", default=1024,type=int, help='Socket recv buffer.', dest="socket_buffer")
    parser.add_argument("--socket-path-list","-sp-list", nargs='+', default='/var/tmp/sock_test.s', help='Unix socket path list.', dest="socket_path_list")
    parser.add_argument("--address-list","-addr-list", nargs='+', default='0.0.0.0', help='List of TCP Server address:port.', dest="address_list")
    parser.add_argument("--zero-bytes","-zb", default='ZB', help='What to return when a zero lengh response is returned from the serial port. Default \'ZB\'.encode(\'utf-8\')', dest="zero_bytes")
    parser.add_argument("--reconnect-interval", default=5, type=int, help='TCP Server reconnect interval.', dest="reconnect_interval")
    args = parser.parse_args()

    if type(args.address_list) != list:
        args.address_list = [args.address_list]

    if type(args.socket_path_list) != list:
        args.socket_path_list = [args.socket_path_list]

    if len(args.socket_path_list) != len(args.address_list):
        logger.warning('Parameter --socket-path-list doesn\'t have the same a mount of entries as --address-list. UNIX sockets will be created under /var/tmp/(address).')

        if len(args.address_list) > len(args.socket_path_list):
            for i in range(len(args.address_list)):
                if i < len(args.socket_path_list):
                    continue
                args.socket_path_list.append('/var/tmp/{}'.format(args.address_list[i]))
    with ThreadPoolExecutor() as executor:
        for addr, path in zip(args.address_list, args.socket_path_list):
            executor.submit(TcpUnixBind(address=addr, socket_path=path, **vars(args)).start)
