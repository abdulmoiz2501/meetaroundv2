import 'dart:ui';

import 'package:get/get.dart';

void showJammingRequestDialog({
  required String name,
  required VoidCallback onAccept,
  required VoidCallback onReject,
}) {
  Get.defaultDialog(
    title: "Jamming Request",
    middleText: "User $name wants to jam with you. Do you want to accept?",
    textCancel: "Reject",
    textConfirm: "Accept",
    onCancel: onReject,
    onConfirm: onAccept,
  );
}
