require 'pty'
require 'expect'

# 対話型シェルでちゃんと返す関数
def exec_as_root( cmd )
  $expect_verbose = true

  PTY.spawn( cmd ) { |r, w|
    w.sync = true
    r.expect( /Username for 'https:\/\/github\.com': $/ ) {
      w.puts ENV['Git_ID']
      sleep 2
    }
    domain = '@' + 'gmail.com'
    r.expect( /Password for 'https:\/\/xryuseix#{domain}': $/ ) {
      w.puts ENV['Git_PW']
      sleep 2
    }
  }
end