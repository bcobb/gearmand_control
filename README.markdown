# GearmandControl

Control a [gearmand] process with Ruby. In writing Gearman workers and clients, I've found this useful when running integration tests.

## Example

```ruby
# start gearmand, listening on 4730
gearmand = GearmandControl.new
gearmand.start

# attempt to open a TCP connection on localhost:4730
# raises GearmandControl::TestFailed if it cannot
gearmand.test!

# get the process's PID
gearmand.pid

# have we started?
gearman.started?

# stop gearmand
gearmand.stop
```

## TODO

- `gearmand` takes a number of options. Make it easy to set those.

[gearmand]: http://gearman.org/
