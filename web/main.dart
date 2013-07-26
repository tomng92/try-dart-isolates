import 'dart:html';
import 'dart:isolate';

SendPort reverserIsolate;
SendPort changeCaseIsolate;

var reverserIsolateFile = 'reverser.dart';
var changeCaseIsolateFile = 'change_case.dart';

void main() {
  
  query("#button1")..onClick.listen(reverseText);
  query("#button2")..onClick.listen(changeCaseText);
  
 
  if (identical(1, 1.0)) {  // hack to detect if we're in JS
    reverserIsolateFile = 'reverser.dart.js';
    changeCaseIsolateFile = 'changeCase.dart.js';
  }
  
  reverserIsolate = spawnUri(reverserIsolateFile);
  changeCaseIsolate = spawnUri(changeCaseIsolateFile);
}

/**
 * Invokes the reverser isolate.
 */
void reverseText(MouseEvent event) {

  ButtonElement button = query("#button1");
  var text = button.text;
  reverserIsolate.call(text).then((result) {
    button.text = result;
  });
}

/**
 * Invokes the changeCase isolate.
 */
void changeCaseText(MouseEvent event) {

  ButtonElement button = query("#button2");
  var text = button.text;
  changeCaseIsolate.call(text).then((result) {
    button.text = result;
  });
}

