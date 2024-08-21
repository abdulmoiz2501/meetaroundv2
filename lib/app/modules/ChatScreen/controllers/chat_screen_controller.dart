import 'dart:convert';
import 'package:get/get.dart';
import 'package:scratch_project/app/controllers/user_controller.dart';
import 'package:scratch_project/app/models/chat_model.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_client/web_socket_client.dart';
var chatCntr = Get.find<ChatScreenController>();
class ChatScreenController extends GetxController {
  RxList<ChatModel> chatModels = RxList<ChatModel>([]);
  var userController = Get.find<UserController>();

  final count = 0.obs;
  late WebSocket channel;
  bool hasMessages = true;

  @override
  void onInit() {
    connectWebSocket();
    super.onInit();
  }

  void connectWebSocket() {
    print("::: inside connect web socket");
    channel = WebSocket(
      Uri.parse('wss://meet-around-apis-production.up.railway.app/chat'),
    );
    Future.delayed(const Duration(seconds: 5), () {
      channel.send('{"type": "init","userId": ${userController.user.value.id}}');
      print("::: User id while connecting to websocket ${userController.user.value.id}");
    });

    channel.messages.listen((message) {
      // Handling incoming messages
      if (message != '{"type":"init"}') {
        print('::: WebSocket connection status: ${channel.connection.state}');
        print('::: WebSocket Response: $message');

        if (message.startsWith('[')) {
          List<dynamic> jsonResponse = jsonDecode(message);
          List<ChatModel> parsedChatModels = jsonResponse
              .map((json) => ChatModel.fromJson(json))
              .toList();

          chatModels.addAll(parsedChatModels);
        } else {
          Map<String, dynamic> jsonResponse = jsonDecode(message);
          Messages newMessage = Messages.fromJson(jsonResponse);

          int receiverId = jsonResponse['receiverId'];

          if(receiverId == userController.user.value.id){
            int senderId = jsonResponse['senderId'];
            print("The response is $receiverId");
           chatModels.firstWhereOrNull(
              (model) => model.receiverId == senderId)?.messages?.add(newMessage);
              chatModels.refresh();
          }else{
            print("The response is $receiverId");
           chatModels.firstWhereOrNull(
              (model) => model.receiverId == receiverId)?.messages?.add(newMessage);
              chatModels.refresh();
          }

          
        }
      }
    }, onError: (error) {
      print('::: WebSocket Error: $error');
      Get.snackbar('Error', 'WebSocket connection error: $error',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    }, onDone: () {
      print('::: WebSocket connection closed');
      Get.snackbar('Info', 'WebSocket connection closed',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  void sendMessage(String content, String receiverId, String senderId) {
    print("::: Sending message $content from $senderId to $receiverId");
    channel.send(
        '{"type": "message","senderId": $senderId,"receiverId": $receiverId,"content": "$content"}');
  }

  void increment() => count.value++;
}
