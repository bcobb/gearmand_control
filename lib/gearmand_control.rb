require 'socket'
require 'timeout'

class GearmandControl

  UNSTARTED = :unstarted unless defined? UNSTARTED

  class TestFailed < RuntimeError ; end

  attr_reader :address
  
  def initialize(port)
    @port = port
    @command = 'gearmand'
    @io = UNSTARTED
    @address = ['localhost', port].join(':')
  end

  def pid
    started? ? @io.pid : -1
  end

  def start
    process = [@command, '-p', @port]
    @io = IO.popen(process.map(&method(:String)))
    test!
  end

  def started?
    @io != UNSTARTED
  end

  def stop(signal = :TERM)
    if started?
      Process.kill(signal, pid)
      @io.close
      @io = UNSTARTED
    end
  end

  def test!
    socket = nil

    Timeout.timeout(0.5, TestFailed) do
      begin
        socket = TCPSocket.new('localhost', 4730)
      rescue Errno::ECONNREFUSED
        sleep (rand / 100.0)

        retry
      ensure
        socket.close unless socket.nil?
      end
    end

    true
  end

end
