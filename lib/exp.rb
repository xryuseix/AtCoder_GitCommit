require 'pty'
require 'expect'
# cmd = 'git push origin master'
# PTY.getpty(cmd) do | i,o |
#   o.sync = true
#   i.expect(/Username for 'https:\/\/github\.com':/, 10) { |line| #入力プロンプトくるまでreadline繰り返す
#     puts line
#     o.puts ENV['Git_ID']
#     o.flush
#   }
#   while( i.eof? == false )
#     puts i.gets
#   end
# end
def exec_as_root( cmd )
  $expect_verbose = true

  PTY.spawn( cmd ) { |r, w|
    w.sync = true
    r.expect( /Username for 'https:\/\/github\.com': $/ ) {
      w.puts ENV['Git_ID']
      sleep 2
    }
    r.expect( /Password for 'https:\/\/xryuseix@github\.com': $/ ) {
      w.puts ENV['Git_PW']
      sleep 2
    }
    while( r.eof? == false )
      puts r.gets
    end
  }
end