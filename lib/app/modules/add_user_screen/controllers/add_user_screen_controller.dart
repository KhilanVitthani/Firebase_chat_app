import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:singal_chat_app/Models/userModels.dart';
import 'package:singal_chat_app/constants/api_constants.dart';
import 'package:singal_chat_app/constants/sizeConstant.dart';
import 'package:singal_chat_app/main.dart';
import 'package:singal_chat_app/service/Firebase_service.dart';

class AddUserScreenController extends GetxController {
  UserModels? userData;
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (!isNullEmptyOrFalse(box.read(ArgumentConstant.userUid))) {
        userData = await FirebaseService().getUserData(
            context: Get.context!, uid: box.read(ArgumentConstant.userUid));
        print(userData!.FriendsList);
      }
    });
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
}
