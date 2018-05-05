import std.socket;
import std.stdio;

void main()
{
    auto skt = new TcpSocket();
    scope(exit) {
      skt.shutdown(SocketShutdown.BOTH);
      skt.close;
    }
    skt.bind(new InternetAddress(4444));
    skt.listen(1); // 1 pending incoming connections are queued
    writefln("Server on port 4444");
    while (true) {
      auto sn2 = skt.accept();
      writeln("connected");
      sn2.send("hello\n");
    }
}
