import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:singal_chat_app/Models/userModels.dart';
import 'package:singal_chat_app/app/routes/app_pages.dart';
import 'package:singal_chat_app/constants/api_constants.dart';
import 'package:singal_chat_app/constants/color_constant.dart';
import 'package:singal_chat_app/constants/sizeConstant.dart';
import 'package:singal_chat_app/main.dart';
import 'package:singal_chat_app/service/Firebase_service.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetWidget<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: appTheme.appbarTheme,
            title: Text("${controller.username.value}"),
            centerTitle: true,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: IconButton(
                    onPressed: () async {
                      await FirebaseService().logOut(context: context).then(
                        (value) {
                          box.erase();
                          Get.offAllNamed(Routes.LOGIN_PAGE);
                        },
                      );
                    },
                    icon: Icon(Icons.logout)),
              )
            ],
          ),
          body: Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseService().getAllUsersList(),
              builder: (context, snapShot) {
                if (snapShot.hasData) {
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
                    List<UserModels> userList = [];
                    List<UserModels> friendList = [];
                    snapShot.data!.docs.forEach((element) {
                      userList.add(UserModels.fromJson(
                          element.data() as Map<String, dynamic>));
                    });
                    UserModels myUserData = userList.singleWhere((element) =>
                        element.uid == box.read(ArgumentConstant.userUid));

                    if (!isNullEmptyOrFalse(myUserData.FriendsList)) {
                      myUserData.FriendsList!.forEach((element) {
                        friendList.add(
                            userList.singleWhere((ele) => ele.uid == element));
                      });
                    }
                    return ListView.builder(
                        padding: EdgeInsets.symmetric(
                            vertical: MySize.getHeight(20),
                            horizontal: MySize.getWidth(10)),
                        itemCount: friendList.length,
                        itemBuilder: (context, index) {
                          UserModels userModels = friendList[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    MySize.getHeight(10))),
                            child: InkWell(
                              onTap: () {
                                Get.offAndToNamed(Routes.CHAT_SCREEN,
                                    arguments: {
                                      ArgumentConstant.friendData: userModels,
                                    });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: MySize.getHeight(25),
                                    vertical: MySize.getWidth(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          );
                        });
                  }
                }
                return SizedBox();
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: "tag001",
            backgroundColor: appTheme.appbarTheme,
            onPressed: () {
              Get.toNamed(Routes.ADD_USER_SCREEN);
            },
            child: Icon(Icons.add),
          ),
        ),
      );
    });
  }
}
