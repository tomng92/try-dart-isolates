import 'dart:isolate';
import 'dart:html';

/**
 * Isolate to download a text file.
 * 
 */
main() {
    port.receive((msg, SendPort replyTo) {
      
      String url = msg;  
      
      try {
        HttpRequest request = new HttpRequest();
        request.getString(url).then((String result) {
          replyTo.send(result);
        });
      } catch (exc) {
        replyTo.send(exc.toString());
      }
  });
}
