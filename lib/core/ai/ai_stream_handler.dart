import 'dart:async';

class AIStreamHandler {
  final StreamController<String> _controller = StreamController<String>.broadcast();
  bool _isStreaming = false;

  Stream<String> get stream => _controller.stream;
  bool get isStreaming => _isStreaming;

  void startStreaming() {
    _isStreaming = true;
  }

  void addToken(String token) {
    if (_isStreaming) {
      _controller.add(token);
    }
  }

  void completeStreaming() {
    _isStreaming = false;
    _controller.close();
  }

  void cancelStreaming() {
    _isStreaming = false;
    _controller.close();
  }

  void dispose() {
    _controller.close();
  }
}
