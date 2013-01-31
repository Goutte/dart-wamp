part of wamp.server;

class Client {
  String sessionId;
  WebSocketConnection conn;

  Set<String> topics = new Set();
  Map<String, String> prefixes = new Map();

  Client(this.conn) {
    var rnd = new Random();
    sessionId = rnd.nextInt(99999).toString(); // TODO: use some kind of hash.
  }

  void send(msg) {
    conn.send(JSON.stringify(msg));
  }

  void welcome([serverId = "srv"]) {
    send([MessageType.WELCOME, sessionId, PROTOCOL_VERSION, serverId]);
  }

  void callResult(String callId, result) { // TODO: if result is not a String, call JSON.stringify();
    send([MessageType.CALL_RESULT, callId, result]);
  }

  void callError(String callId, String errorUri, String errorDescription) {
    send([MessageType.CALL_ERROR, callId, errorUri, errorDescription]);
  }

  void event(String topicId, event) {
    send([MessageType.EVENT, topicId, event]);
  }
}
