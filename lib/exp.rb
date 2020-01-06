require 'pty'
require 'expect'
# cmd = 'git push origin master'
# PTY.getpty(cmd) do | i,o |
#     o.sync = true
#     i.expect(/password:/,10){|line| ##入力プロンプトくるまでreadline繰り返す
#         puts line
#         o.puts ENV['Git_PW']
#         o.flush
#     }
#     while( i.eof? == false )
#         puts i.gets
#     end
# end