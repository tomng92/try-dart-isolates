import 'dart:html';
import 'dart:isolate';

SendPort reverser;

void main() {
  
  
  query("#button1")..onClick.listen(reverseText);
  
  var serviceFile = 'reverser.dart';
  
  if (identical(1, 1.0)) {  // hack to detect if we're in JS
    serviceFile = 'reverser.dart.js';
  }
  
    reverser = spawnUri(serviceFile);
}

/**
 * This function invokes the reverser isolate.
 *  
 */
void reverseText(MouseEvent event) {

  ButtonElement button = query("#button1");
  var text = button.text;
  reverser.call(text).then((reversed) {
    button.text = reversed;
  });
}

