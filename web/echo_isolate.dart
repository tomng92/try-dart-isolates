
import 'dart:isolate';
import 'dart:mirrors';


/**
 * Isolate that echoes objects passed to it.
 */
main() {
  port.receive((msg, SendPort replyTo) {
    
    InstanceMirror mirror = reflect(msg);
    ClassMirror clazz = mirror.type;
    String shortClassName = MirrorSystem.getName(clazz.simpleName); // 
    
    print('echo received "$msg" of type \'$shortClassName\'');
    
    //replyTo.send("Received $shortClassName ${msg}");
    try {
      replyTo.send(msg); //
    } catch (e) {
      replyTo.send(e.toString());
    }
  });
}