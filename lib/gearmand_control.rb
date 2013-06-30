require 'socket'
require 'timeout'

class GearmandControl

  UNSTARTED = :unstarted unless defined? UNSTARTED

  class TestFailed < RuntimeError ; end
  
  def initialize
    @command = "gearmand"
    @io = UNSTARTED
  end

  def pid
    started? ? @io.pid : -1
  end

  def start
    @io = IO.popen('gearmand')
  end

  def started?
    @io != UNSTARTED
  end

  def stop(signal = :TERM)
    if started?
      Process.kill(:TERM, pid)
      @io.close
      @io = UNSTARTED
    end
  end

  def test!
    socket = nil

    Timeout.timeout(0.05, TestFailed) do
      begin
        socket = TCPSocket.new('localhost', 4730)
      rescue Errno::ECONNREFUSED
        retry
      ensure
        socket.close unless socket.nil?
      end
    end

    true
  end

end
