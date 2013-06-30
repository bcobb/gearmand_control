require 'gearmand_control'

describe GearmandControl do

  before do
    @control = GearmandControl.new
  end

  after do
    @control.stop
  end

  it 'starts gearmand' do
    @control.start

    expect(Process.getsid(@control.pid)).to be_a(Fixnum)
  end

  it 'stops gearmand' do
    @control.start
    pid = @control.pid
    @control.stop

    expect do
      Process.getsid(pid)
    end.to raise_error(Errno::ESRCH)
  end

  it 'tests succesfully after starting gearmand' do
    @control.start

    expect do
      @control.test!
    end.to_not raise_error
  end

  it 'raises if its test fails' do
    expect do
      @control.test!
    end.to raise_error(GearmandControl::TestFailed)
  end

  it 'knows if the daemon has been started' do
    @control.start

    expect(@control).to be_started
  end

end
