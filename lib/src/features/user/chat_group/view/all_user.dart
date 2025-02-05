import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/app_images.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';
import 'package:tech_takes_app/src/features/user/chat_group/controller/chatgroup_controller.dart';
import 'package:tech_takes_app/src/features/user/chat_group/model/model.dart';
import 'package:tech_takes_app/src/features/user/chat_group/repository/firebase_services.dart';
import 'package:tech_takes_app/src/features/user/chat_group/view/message_card.dart';
import 'package:tech_takes_app/src/features/user/prediction/widget/custom_container.dart';

import '../../settings/view/notification_page.dart';

class GroupChatScreen extends StatefulWidget {
  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ChatGroupController controller = Get.put(ChatGroupController());

  User? _user;

  List<GroupChatModel> dataList = [];

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _addUserToGroup(); // Add the user to the group if it's their first time
  }

  // Add the user to the group chat when they first join
  Future<void> _addUserToGroup() async {
    if (_user != null) {
      await GroupChatApis
          .addUserToGroup(); // Add user to group and send welcome message
    }
  }

  // Send the message to the group

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80),
          child: DecoratedAppBar(
            text: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                'Chatroom',
                style: textTheme(context).titleMedium?.copyWith(
                      color: colorScheme(context).surface,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            leadingWidget: GestureDetector(
              onTap: () {
                Get.to(NotificationsPage());
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SvgPicture.asset(
                  AppIcons.bellIcon,
                  height: 20,
                  color: colorScheme(context).surface,
                ),
              ),
            ),
            title: 'Chatroom',
            // endWidget: SizedBox(),
            endWidget: PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              // offset: const Offset(0, 20),
              elevation: 0,
              shadowColor: Colors.transparent,
              menuPadding: EdgeInsets.only(top: 35),
              padding: EdgeInsets.all(0),
              color: Colors.transparent,
              itemBuilder: (context) => [
                PopupMenuItem(
                  enabled: false,
                  child: GestureDetector(
                    onTap: () {
                      // Get.to(PastPredictionPage());
                    },
                    child: CustomContainer(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 15),
                      color: Colors.white,
                      // height: 17,

                      borderRadius: 10,
                      borderColor: Color(0xffD8D8D8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.muteBell,
                                color: Color(0xff858585),
                                height: 17,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Mute notification",
                                  style: textTheme(context).bodySmall?.copyWith(
                                        color: Color(0xff858585),
                                      )),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.deleteIcon,
                                color: Color(0xff858585).withOpacity(.8),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Delete chat history",
                                  style: textTheme(context).bodySmall?.copyWith(
                                        color: Color(0xff858585),
                                      )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // endWidget: SizedBox(),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            // Display messages from the group chat
            Expanded(
              child: StreamBuilder(
                stream: GroupChatApis.getAllMessages(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var data = snapshot.data!.docs;
                  dataList = data
                          ?.map((e) => GroupChatModel.fromJson(e.data()))
                          .toList() ??
                      [];
                  return ListView.builder(
                    reverse: true,
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      return MessageCard(
                        chatModel: dataList[index],
                      );
                    },
                  );
                },
              ),
            ),
            // Text input and send button
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: TextFormField(
            //           controller: _controller,
            //           decoration: InputDecoration(
            //             hintText: 'Type your message...',
            //             border: OutlineInputBorder(),
            //           ),
            //         ),
            //       ),
            //       IconButton(
            //         icon: Icon(Icons.send),
            //         onPressed: () async {
            //           if (_controller.text.isNotEmpty) {
            //             String msg = _controller.text;
            //             await GroupChatApis.sendGroupMessage(
            //               msg,
            //             ); // Send the message to Firestore
            //             _controller
            //                 .clear(); // Clear the input field after sending the message
            //           }
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            _buildMessageInput(context, controller),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(
      BuildContext context, ChatGroupController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      // color: Colors.grey.shade300,
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  controller.toggleEmojiPicker();
                  controller.focusNode.unfocus();
                  log('message');
                },
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: AppColor.grey.withOpacity(0.4))),
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Icon(Icons.emoji_emotions, color: AppColor.grey),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: TextField(
                  controller: controller.messageController,
                  focusNode: controller.focusNode,
                  decoration: InputDecoration(
                    hintText: "Write a message",
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: controller.pickImageFromGallery,
                          child: Icon(Icons.attach_file,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: controller.pickImageFromCamera,
                          child:
                              const Icon(Icons.camera_alt, color: Colors.black),
                        ),
                        // IconButton(
                        //   icon: SvgPicture.asset(AppIcons.sendIcon),
                        //   onPressed: () {
                        //     if (controller.messageController.text.isNotEmpty) {
                        //       controller
                        //           .sendMessage(controller.messageController.text);
                        //     }
                        //   },
                        // ),
                        SizedBox(width: 10)
                      ],
                    ),
                    hintStyle: textTheme(context).bodySmall?.copyWith(
                        color: colorScheme(context).onSurface.withOpacity(.7),
                        fontWeight: FontWeight.w700),
                    filled: true,
                    fillColor: Color(0xffF3F6F6),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 13),
                  ),
                  onChanged: (text) {
                    if (text.endsWith('@')) {
                      controller.showMentionList.value = true;
                    } else {
                      controller.showMentionList.value = false;
                    }
                  },
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: AppColor.grey.withOpacity(0.4))),
                  child: InkWell(
                      onTap: () async {
                        if (controller.messageController.text.isNotEmpty) {
                          String msg = controller.messageController.text;

                          await GroupChatApis.sendGroupMessage(
                            msg,
                          ); // Send the message to Firestore
                          controller.messageController
                              .clear(); // Clear the input field after sending the message
                          log('Message send succesfully');
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(AppIcons.sendIcon),
                      ))),
            ],
          ),
          Obx(() => controller.showEmojiPicker.value
              ? EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    controller.messageController.text += emoji.emoji;
                  },
                )
              : SizedBox()),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
