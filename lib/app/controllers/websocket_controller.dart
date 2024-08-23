import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:scratch_project/app/controllers/user_controller.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketController extends GetxController {
  late WebSocketChannel _channel;
  final UserController userController = Get.put(UserController());

  var isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    connectWebSocket();
  }

  void connectWebSocket() {
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse(
            'wss://meet-around-apis-production.up.railway.app/ws/playback'),
      );
      isConnected.value = true;

      sendInit(userController.user.value.id);
    } catch (e) {
      isConnected.value = false;
      print("Failed to connect to WebSocket: $e");
    }
  }

  Stream<String> get messageStream =>
      _channel.stream.map((event) => event.toString());

  void sendInit(int userId) {
    final Logger logger = Logger();
    logger.log(Level.info, "Sending init message to WebSocket");
    if (isConnected.value) {
      final payload = jsonEncode({"type": "init", "userId": userId});
      _channel.sink.add(payload);
      print("Sent: $payload");
    } else {
      print("WebSocket is not connected, unable to send init message");
    }
  }

  void sendJammingRequest(String userId, String targetUserId) {
    if (isConnected.value) {
      final payload = jsonEncode(
          {"type": "request", "userId": userId, "targetUserId": targetUserId});
      _channel.sink.add(payload);
      print("Sent: $payload");
    } else {
      print("WebSocket is not connected, unable to send jamming request");
    }
  }

  void sendJammingResponse(String userId, String action) {
    if (isConnected.value) {
      final payload =
          jsonEncode({"type": "response", "userId": userId, "action": action});
      _channel.sink.add(payload);
      print("Sent: $payload");
    } else {
      print("WebSocket is not connected, unable to send jamming response");
    }
  }

  void sendSongUrl(
      String userId, String targetUserId, String songUrl, int songDuration) {
    if (isConnected.value) {
      final payload = jsonEncode({
        "type": "url",
        "userId": userId,
        "targetUserId": targetUserId,
        "songUrl": songUrl,
        "songDuration": songDuration
      });
      _channel.sink.add(payload);
      print("Sent: $payload");
    } else {
      print("WebSocket is not connected, unable to send song URL");
    }
  }

  @override
  void onClose() {
    _channel.sink.close();
    super.onClose();
  }
}

class LocationWebSocketController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var webSocketResponse = ''.obs;
}
