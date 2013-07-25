// reverser.dart
// http://blog.sethladd.com/2013/04/dynamically-load-code-with-dart.html
// invoked from the main program


import 'dart:isolate';

main() {
  port.receive((msg, SendPort replyTo) {
    
    print('reverser received "$msg"');
    var reverse = msg as String;
    var buffer = new StringBuffer();
    for (var i = reverse.length - 1; i >= 0; i--) {
      buffer.write(reverse[i]);
    }
    replyTo.send(buffer.toString());
  });
}