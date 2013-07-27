import 'dart:html';
import 'dart:isolate';

SendPort reverserIsolate;
SendPort changeCaseIsolate;

/**
 * This application does 2 things: reverse text and flip text case.
 * We use 2 isolates, one for each function.
 * 
 * This application illustrates the main idea behind isolates.
 * Isolate may be thought as a library that performs some functionality.
 * Isolates have these characteristics:
 *   - they are isolated from each other and from the main app.
 *   - they communicate with the main app via messages.
 *   - messages are simple data structures (numbers, string, hash maps, lists)
 *   
 *  
 */
var reverserIsolateFile = 'reverser.dart';
var changeCaseIsolateFile = 'change_case.dart';

void main() {
  
  query("#button1")..onClick.listen(reverseText);
  query("#button2")..onClick.listen(changeCaseText);
  
 
  if (identical(1, 1.0)) {  // hack to detect if we're in JS
    reverserIsolateFile = 'reverser.dart.js';
    changeCaseIsolateFile = 'change_case.dart.js';
  }
  
  reverserIsolate = spawnUri(reverserIsolateFile);
  changeCaseIsolate = spawnUri(changeCaseIsolateFile);
}

/**
 * Invokes reverser isolate.
 */
void reverseText(MouseEvent event) {
  InputElement inputElem = query("#input-field");
  var text = inputElem.value;
  reverserIsolate.call(text).then((result) {
    inputElem.value = result;
  });
}

/**
 * Invokes changeCase isolate.
 */
void changeCaseText(MouseEvent event) {
  InputElement inputElem = query("#input-field");
  var text = inputElem.value;
  changeCaseIsolate.call(text).then((result) {
    inputElem.value = result;
  });
}

