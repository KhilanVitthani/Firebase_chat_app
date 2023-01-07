import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:singal_chat_app/Models/userModels.dart';
import 'package:singal_chat_app/constants/api_constants.dart';
import 'package:singal_chat_app/constants/sizeConstant.dart';
import 'package:singal_chat_app/main.dart';
import 'package:singal_chat_app/service/Firebase_service.dart';

import '../controllers/add_user_screen_controller.dart';

class AddUserScreenView extends GetWidget<AddUserScreenController> {
  const AddUserScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Friends'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseService().getAllUsersList(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Something went wrong..."),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                            vertical: MySize.getHeight(20),
                            horizontal: MySize.getWidth(10)),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          UserModels userModels = UserModels.fromJson(
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>);
                          return (userModels.uid !=
                                  box.read(ArgumentConstant.userUid))
                              ? Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          MySize.getHeight(10))),
                                  child: InkWell(
                                    onTap: () async {
                                      userModels.FriendsList!.add(
                                          controller.userData!.uid.toString());
                                      controller.userData!.FriendsList!
                                          .add(userModels.uid.toString());
                                      print(userModels.FriendsList);
                                      print(
                                          "Controller:-${controller.userData!.FriendsList}");

                                      await FirebaseService().addFriend(
                                        context: context,
                                        friendsFriendsList:
                                            userModels.FriendsList!,
                                        myFriendList:
                                            controller.userData!.FriendsList!,
                                        friendsUid: userModels.uid!,
                                      );
                                      Get.back();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MySize.getHeight(25),
                                          vertical: MySize.getWidth(20)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(userModels.Name.toString()),
                                          Spacing.height(10),
                                          Text(userModels.uid.toString()),
                                          Spacing.height(10),
                                          Text(userModels.Email.toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox();
                        }),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
