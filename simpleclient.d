import std.socket;
import std.stdio;
import std.format;
import std.concurrency;

void main()
{
    auto localadd = getAddress("127.0.0.1", 50101)[0];
    writefln("Client on port 50101");
    foreach(i; 0..10) {
      auto skt = new TcpSocket(localadd);
      writeln("connected");

      auto line = skt.getLine;
      writeln(line);
      if (line == "start") {
        spawn(&worker);
      }
      skt.send(format("test response %s \n", i));
      skt.shutdown(SocketShutdown.BOTH);
      skt.close;
    }
}

string getLine(TcpSocket skt) {
  char[] line;
  char[1] buf;
  while(skt.receive(buf)) {
    if (buf[0] == '\n') break;
    line ~= buf;
  }
  return line.dup;
}

void worker() {
  writeln("worker started");
}
