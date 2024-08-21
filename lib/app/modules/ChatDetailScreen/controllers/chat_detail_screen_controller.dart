import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scratch_project/app/modules/ChatDetailScreen/views/chat_detail_screen_view.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_client/web_socket_client.dart';

class ChatDetailScreenController extends GetxController {
  final count = 0.obs;
  late WebSocket channel;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  


  void increment() => count.value++;
}
