import 'dart:isolate';

/**
 * Isolate used to change case of text
 */
main() {
  port.receive((msg, SendPort replyTo) {
    
    RegExp uppercaseRegex = new RegExp("[A-Z]");

    var inputText = msg as String;
    var buffer = new StringBuffer();
    for (var i = 0; i < inputText.length; i++) {
      
      String char = inputText[i];
      if (uppercaseRegex.hasMatch(char)) {  
        buffer.write(char.toLowerCase());
      } else {
        buffer.write(char.toUpperCase());
      }
    }
    replyTo.send(buffer.toString());
  });
}