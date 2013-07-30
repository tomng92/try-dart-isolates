import 'dart:isolate';
import 'my_object.dart';

/**
 * Isolate to reverse text.
 * For example "hello" -becomes-> 'olleh'.
 */
main() {
  port.receive((msg, SendPort replyTo) {
    
    print('reverser received "$msg"');
    var inputText = msg as String;
    var buffer = new StringBuffer();
    for (var i = inputText.length - 1; i >= 0; i--) {
      buffer.write(inputText[i]);
    }
    replyTo.send(buffer.toString());
  });
}