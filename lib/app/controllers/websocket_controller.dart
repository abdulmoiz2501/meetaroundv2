
import 'package:get/get.dart';
class LocationWebSocketController extends GetxController {
  // late WebSocket _channel;
  // bool isConnected = false;

  // @override
  // void onInit() {
  //   super.onInit();
  //   connectToWebSocket();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   _channel.close();
  //   super.onClose();
  // }

  // Future<void> connectToWebSocket() async {
  //   _channel = WebSocket(
  //     Uri.parse(
  //         'wss://meet-around-apis-production.up.railway.app/ws}'),
  //   );

  //   _channel.messages.listen(
  //     (message) {
  //       print("::: Messages from Web Socket $message");
  //       print("::: connection of web socket ${_channel.connection.state}");
  //     },
  //     onDone: () {
  //       print("::: on Done socket");
  //       isConnected = false;
  //       reconnectWebSocket();
  //     },
  //     onError: (error) {
  //       print("::: on Error socket");
  //       isConnected = false;
  //       reconnectWebSocket();
  //     },
  //   );
  // }

  // void reconnectWebSocket() {
  //   Future.delayed(Duration(seconds: 5), () {
  //     if (!isConnected) {
  //       connectToWebSocket();
  //     }
  //   });
  // }

  // void addPayload(String userid, double latitude,double longitude) {
  //   _channel.send(
  //       '{"userId": $userid,"latitude": "$latitude","longitude": "$longitude"}');
  // }

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var webSocketResponse = ''.obs;

  //   Future<void> getCurrentLocation(String uid) async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     Get.snackbar('Error', 'Location services are disabled.',
  //         backgroundColor: VoidColors.primary, colorText: VoidColors.secondary);
  //     return;
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       Get.snackbar('Error', 'Location permissions are denied.',
  //           backgroundColor: VoidColors.primary,
  //           colorText: VoidColors.secondary);
  //       return;
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     Get.snackbar('Error',
  //         'Location permissions are permanently denied, we cannot request permissions.',
  //         backgroundColor: VoidColors.primary,
  //         colorText: VoidColors.whiteColor,
  //         snackPosition: SnackPosition.BOTTOM);
  //     return;
  //   }

  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   latitude.value = position.latitude;
  //   longitude.value = position.longitude;
  //   print("::: Got current pposition ${position.latitude} ${position.longitude}");

  //   connectWebSocket('wss://meet-around-apis-production.up.railway.app/ws', 
  //     {
  // "userId": uid,
  // "latitude": "${latitude.value}",
  // "longitude": "${longitude.value}"
  //   });
  // }

  // ///Web socket part
  // void connectWebSocket(String url, Map<String,dynamic> payload) {
  //   final channel = WebSocketChannel.connect(
  //     Uri.parse(url),
  //   );

  //   channel.sink.add(jsonEncode({
  //     payload
  //   }));

  //   channel.stream.listen((message) {
  //     webSocketResponse.value = message;
  //     print('::: WebSocket Response: $message');
  //   }, onError: (error) {
  //     print('WebSocket Error: $error');
  //     Get.snackbar('Error', 'WebSocket connection error: $error',
  //         backgroundColor: VoidColors.primary,
  //         colorText: VoidColors.whiteColor,
  //         snackPosition: SnackPosition.BOTTOM);
  //   }, onDone: () {
  //     print('WebSocket connection closed');
  //     Get.snackbar('Info', 'WebSocket connection closed',
  //         backgroundColor: VoidColors.primary,
  //         colorText: VoidColors.whiteColor,
  //         snackPosition: SnackPosition.BOTTOM);
  //   });
  // }


}