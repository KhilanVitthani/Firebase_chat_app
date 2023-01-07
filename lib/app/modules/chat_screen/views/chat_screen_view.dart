import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:singal_chat_app/app/routes/app_pages.dart';
import 'package:singal_chat_app/constants/color_constant.dart';
import 'package:singal_chat_app/constants/sizeConstant.dart';
import 'package:singal_chat_app/constants/text_field.dart';

import '../../../../Models/chat_data_model.dart';
import '../../../../constants/api_constants.dart';
import '../../../../main.dart';
import '../../../../service/Firebase_service.dart';
import '../controllers/chat_screen_controller.dart';

class ChatScreenView extends GetWidget<ChatScreenController> {
  const ChatScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAndToNamed(Routes.HOME);
        return await true;
      },
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: appTheme.appbarTheme,
              title: Text('${controller.friendData!.Name}'),
              centerTitle: true,
              leading: GestureDetector(
                onTap: () async {
                  Get.offAllNamed(Routes.HOME);
                },
                child: Container(
                  padding: EdgeInsets.only(left: MySize.getWidth(10)),
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MySize.getWidth(8),
                  vertical: MySize.getHeight(5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: MySize.getHeight(5)),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseService()
                            .getChatData(chatId: controller.getChatId()),
                        builder: (context, snapShot) {
                          if (snapShot.hasError) {
                            return Center(
                              child: Text("Something went wrong..."),
                            );
                          } else if (snapShot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            controller.chatDataList.clear();
                            var data = snapShot.data!.docs;
                            if (!isNullEmptyOrFalse(data)) {
                              data.forEach((element) {
                                controller.chatDataList.add(
                                    ChatDataModel.fromJson(element.data()
                                        as Map<String, dynamic>));
                              });
                            }
                            return ListView.separated(
                                reverse: true,
                                itemBuilder: (context, index) {
                                  return Align(
                                    alignment: (controller.chatDataList[index]
                                            .isUsersMsg!.value)
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: (controller
                                              .chatDataList[index]
                                              .isUsersMsg!
                                              .value)
                                          ? CrossAxisAlignment.start
                                          : CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: MySize.getHeight(5),
                                              horizontal: MySize.getHeight(10)),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      MySize.getHeight(5)),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(controller
                                                  .chatDataList[index].msg
                                                  .toString()),
                                              Spacing.height(2),
                                              Text(
                                                DateFormat("hh:mm a").format(
                                                    controller
                                                        .chatDataList[index]
                                                        .dateTime!),
                                                style: TextStyle(
                                                  fontSize:
                                                      MySize.getHeight(10),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: MySize.getHeight(3),
                                  );
                                },
                                itemCount: controller.chatDataList.length);
                          }
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: getTextField(
                          hintText: "Enter your message...",
                          textEditingController:
                              controller.chatController.value,
                          borderColor: appTheme.appbarTheme,
                          onSubmit: (p0) {
                            FirebaseService().addMessageToChat(
                                chatId: controller.getChatId(),
                                chatData: {
                                  "senderId":
                                      box.read(ArgumentConstant.userUid),
                                  "receiverId": controller.friendData!.uid,
                                  "msg": controller.chatController.value.text
                                      .trim(),
                                  "dateTime":
                                      DateTime.now().millisecondsSinceEpoch,
                                });
                            controller.chatController.value.clear();
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            FirebaseService().addMessageToChat(
                                chatId: controller.getChatId(),
                                chatData: {
                                  "senderId":
                                      box.read(ArgumentConstant.userUid),
                                  "receiverId": controller.friendData!.uid,
                                  "msg": controller.chatController.value.text
                                      .trim(),
                                  "dateTime":
                                      DateTime.now().millisecondsSinceEpoch,
                                });
                            controller.sendPushMessage(
                                controller.friendData!.fcmToken.toString(),
                                controller.chatController.value.text.trim(),
                                controller.friendData!.Name.toString());
                            controller.chatController.value.clear();
                          },
                          icon: Icon(Icons.send))
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
