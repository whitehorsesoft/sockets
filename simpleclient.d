import std.socket;
import std.stdio;

void main()
{
    auto localadd = getAddress("127.0.0.1", 4444)[0];
    writefln("Client on port 4444");
    foreach(i; 0..10) {
      auto skt = new TcpSocket(localadd);
      writeln("connected");

      char[] line;
      char[1] buf;
      while(skt.receive(buf)) {
        if (buf[0] == '\n') break;
        line ~= buf;
      }
      writeln(line);
      while (true) {
      }
      skt.shutdown(SocketShutdown.BOTH);
      skt.close;
    }
}
