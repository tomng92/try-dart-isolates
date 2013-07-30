import 'dart:isolate';
import 'dart:mirrors';
import 'my_object.dart';

/**
 * Isolate that echoes objects passed to it.
 */
main() {
  port.receive((msg, SendPort replyTo) {
    
    InstanceMirror mirror = reflect(msg);
    ClassMirror clazz = mirror.type;
    String shortClassName = MirrorSystem.getName(clazz.simpleName); // 
    
    print('echo received "$msg" of type \'$shortClassName\'');
    
    if (shortClassName == 'MyObject') {
      MyObject myObj = msg as MyObject;
      replyTo.send("Received an instance of $shortClassName. Invoking its getter 'name' returns '${myObj.name}'");
    } else {
      replyTo.send(msg.toString());
    }
  });
}