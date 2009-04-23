require 'socket'
module Adhearsion
  module VoIP
    module Asterisk
      module AGI
        class Server
          class ForkServer
            def server
              @tcpServer
            end
            def serve(io)
            end
            def initialize(port,host)
              @port,@host=port,host
              @should_run=true
            end
            def should_run?
              @should_run
            end
            def start
              @tcpServer = TCPServer.new(@host,@port)
              trap("CLD"){
                waitpid(Process.wait,Process::WNOHANG) rescue nil
              }

              while @should_run
                begin
                sock=server.accept_nonblock
                next unless sock
                Process.detach fork {
                  server.close 
                  trap("INT") {  }
                  serve(sock)
                }
                
                rescue Errno::EAGAIN, Errno::ECONNABORTED, Errno::EPROTO, Errno::EINTR => e
                  IO.select([server],[server],[server],1)
                end
              end
            end
            def shutdown
              @should_run=false
            end
            def join
            end
          end
        end
      end
    end
  end
end

