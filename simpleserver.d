import std.socket;
import std.stdio;
import std.string;

void main()
{
    auto skt = new TcpSocket();
    scope(exit) {
      skt.shutdown(SocketShutdown.BOTH);
      skt.close;
    }
    skt.bind(new InternetAddress(50101));
    skt.listen(1); // 1 pending incoming connections are queued
    writefln("Server on port 50101");
    while (true) {
      auto sn2 = skt.accept;
      writeln("connected");
      writeln("what would you like to send?");
      string sendText;
      sendText = readln.strip;
      sn2.send(sendText ~ "\n");

      char[] line;
      char[1] buf;
      while(sn2.receive(buf)) {
        if (buf[0] == '\n') break;
        line ~= buf;
      }
      writeln("recd: " ~ line);
    }
}
