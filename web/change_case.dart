import 'dart:isolate';

/**
 * Isolate used to change case of text.
 * For example "aBc" -becomes-> 'AbC'.
 */
main() {
  port.receive((msg, SendPort replyTo) {
    
    RegExp uppercaseRegex = new RegExp("[A-Z]");

    var inputText = msg as String;
    print('change_case received "$msg"');

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