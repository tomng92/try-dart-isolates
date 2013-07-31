//library try_dart_isolates;

import 'dart:html';
import 'dart:isolate';
import 'dart:collection';
//part 'my_object.dart';

SendPort reverserIsolate;
SendPort changeCaseIsolate;
SendPort sendRequestIsolate;
SendPort objectPassingIsolate;
SendPort reverserSpawnedIsolate;
SendPort echoIsolate;

/**
 * This is the main dart file. It invokes 3 isolates to perform distinct functionalities.
 * This application illustrates the main idea behind isolates.
 * Isolate may be thought as a library that performs some functionality.
 * They have these characteristics:
 *   - they are isolated from each other and from the main app.
 *   - they communicate with the main app via messages.
 *   - messages are simple data structures (numbers, string, hash maps, lists)
 *   
 *  
 */
var reverserIsolateFile = 'reverser_isolate.dart';
var changeCaseIsolateFile = 'change_case_isolate.dart';
var sendRequestIsolateFile = 'send_request_isolate.dart';
var echoIsolateFile = 'echo_isolate.dart';

void main() {
  
  query("#button1").onClick.listen(invokeReverser);
  query("#button2").onClick.listen(invokeChangeCase);
  query("#button3").onClick.listen(invokeSendRequest);
  query("#button4").onClick.listen(invokeReverserSpawn);
  query("#button5").onClick.listen(invokeEchoForMap);
  query("#button6").onClick.listen(invokeEchoForObject);
  
 
  if (identical(1, 1.0)) {  // hack to detect if we're in JS
    reverserIsolateFile = reverserIsolateFile +'.js';
    changeCaseIsolateFile = changeCaseIsolateFile + '.js';
    sendRequestIsolateFile = sendRequestIsolateFile + '.js';
    echoIsolateFile = echoIsolateFile + '.js';
  }
  
  reverserIsolate = spawnUri(reverserIsolateFile);
  changeCaseIsolate = spawnUri(changeCaseIsolateFile);
  sendRequestIsolate = spawnUri(sendRequestIsolateFile);
  reverserSpawnedIsolate = spawnFunction(reverserFunction);
  echoIsolate = spawnUri(echoIsolateFile);
}

get inputText {
  var inputElem = query("#input-field");
  return inputElem.value;
}
set inputText(value) {
  var inputElem = query("#input-field");
  inputElem.value = value;
}

/**
 * Invoke reverser isolate.
 */
void invokeReverser(MouseEvent event) {
  reverserIsolate.call(inputText).then((result) {
    inputText = result;
  });
}

/**
 * Invoke changeCase isolate.
 */
void invokeChangeCase(MouseEvent event) {
  changeCaseIsolate.call(inputText).then((result) {
    inputText = result;
  });
}

/**
 * Invoke sendRequest isolate.
 */
void invokeSendRequest(MouseEvent event) {
  sendRequestIsolate.call(inputText).then((result) {
    inputText = result;
  });
}

/**
 * Invoke reverser isolate created with spawnFunction().
 */
void invokeReverserSpawn(MouseEvent event) {
  reverserSpawnedIsolate.call(inputText).then((result) {
    inputText = result;
  });
}


/**
 * This is the 'function' that is spawned.
 * The spawnFunction isolate lives in the same dart code as the main isolate.
 */
void reverserFunction() {
  port.receive((msg, SendPort replyTo) {
    
    var text = msg as String;
    var buffer = new StringBuffer();
    for (var i = text.length - 1; i >= 0; i--) {
      buffer.write(text[i]);
    }
    replyTo.send(buffer.toString());
  });
}

/**
 * Invoke echo isolate, passing an array to it.
 */
void invokeEchoForArray(MouseEvent event) {
  var textArray = inputText.split(' ');
  echoIsolate.call(textArray).then((result) {
    inputText = result.toString();
  });
}

/**
 * Invoke echo isolate, passing a map to it.
 */
void invokeEchoForMap(MouseEvent event) {
  List<String> textArray = inputText.split(' ');
  Iterable elemIter = textArray.map((String elem) => elem.substring(0, 1)); // take first character
  Map map = new Map.fromIterables(elemIter, textArray);
  echoIsolate.call(map).then((result) {
    inputText = result.toString();
  });
}

/**
 * Invoke echo isolate, passing a map to it.
 */
void invokeEchoForObject(MouseEvent event) {
  MyObject myobj = new MyObject(inputText);
  echoIsolate.call(myobj).then((result) {
    inputText = result.toString();
  });
}


/**
 * Dummy class used to test message passing thru isolates.
 */

class MyObject {
  String name;
  MyObject(this.name);
  String toString() => 'MyObject(name = \'' + this.name + '\')';
}

