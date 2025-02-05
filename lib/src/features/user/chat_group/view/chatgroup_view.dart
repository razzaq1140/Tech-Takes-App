import 'dart:developer';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/app_images.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';
import 'package:tech_takes_app/src/features/user/chat_group/controller/chatgroup_controller.dart';
import 'package:tech_takes_app/src/features/user/settings/view/notification_page.dart';

class ChatGroupPage extends StatelessWidget {
  final ChatGroupController controller = Get.put(ChatGroupController());

  ChatGroupPage({super.key});
  final FocusNode _focusNode = FocusNode();
  void _disableKeyboard() {
    // Unfocus the TextField

    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80),
          child: DecoratedAppBar(
            leadingWidget: GestureDetector(
              onTap: () {
                Get.to(NotificationsPage());
              },
              child: SvgPicture.asset(
                AppIcons.bellIcon,
                height: 20,
                color: colorScheme(context).surface,
              ),
            ),
            title: 'Chatroom',
            // endWidget: Icon(
            //   Icons.more_vert,
            //   color: colorScheme(context).surface,
            // ),
            endWidget: SizedBox(),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final message = controller.messages[index];
                      return buildMessageWidget(context, message, controller);
                    },
                  )),
            ),
            Obx(() => controller.showEmojiPicker.value
                ? EmojiPicker(
                    onEmojiSelected: (category, emoji) {
                      controller.messageController.text += emoji.emoji;
                    },
                  )
                : const SizedBox.shrink()),
            _buildMessageInput(context, controller),
          ],
        ),
      ),
    );
  }

  Widget buildMessageWidget(BuildContext context, ChatMessage message,
      ChatGroupController controller) {
    String formattedTime = _formatTimestamp(message.timestamp);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          message.isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!message.isSentByMe)
          GestureDetector(
            onTap: () => showProfileDialog(
              context,
              message.avatarUrl ??
                  'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?cs=srgb&dl=pexels-olly-733872.jpg&fm=jpg',
              message.isSentByMe,
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                message.avatarUrl ??
                    'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?cs=srgb&dl=pexels-olly-733872.jpg&fm=jpg',
              ),
              radius: 24,
            ),
          ),
        SizedBox(width: 8),
        Flexible(
          child: Column(
            crossAxisAlignment: message.isSentByMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              if (!message.isSentByMe)
                Text(
                  message.senderName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              GestureDetector(
                onLongPress: () {
                  _showReactionPopup(context, controller, message);
                },
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: message.isSentByMe
                            ? Color(0xff1FA76A)
                            : Color(0xffF2F7FB),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(12),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: message.isSentByMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            if (message.imageSend != null &&
                                message.imageSend!.isNotEmpty)
                              GestureDetector(
                                onTap: () => controller.showFullScreenImage(
                                    context, message.imageSend!),
                                child: Hero(
                                  tag: message.imageSend!,
                                  child: Image.file(File(message.imageSend!),
                                      fit: BoxFit.cover,
                                      width: 200,
                                      height: 200),
                                ),
                              )
                            else
                              Text(
                                message.text ?? '',
                                style: TextStyle(
                                  color: message.isSentByMe
                                      ? colorScheme(context).surface
                                      : colorScheme(context).onSurface,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (message.reaction != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5),
                        child: Text(
                          message.reaction!,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: Align(
                  alignment: message.isSentByMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Text(formattedTime,
                      style: textTheme(context).bodySmall?.copyWith(
                          color: AppColor.grey,
                          fontWeight: FontWeight.w700,
                          fontSize: 9)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageInput(
      BuildContext context, ChatGroupController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      // color: Colors.grey.shade300,
      child: Row(
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
                  border: Border.all(color: AppColor.grey.withOpacity(0.4))),
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
                      child: const Icon(Icons.camera_alt, color: Colors.black),
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
                  border: Border.all(color: AppColor.grey.withOpacity(0.4))),
              child: InkWell(
                  onTap: () {
                    if (controller.messageController.text.isNotEmpty) {
                      controller.sendMessage(controller.messageController.text);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(AppIcons.sendIcon),
                  ))),
        ],
      ),
    );
  }

  void _showReactionPopup(BuildContext context, ChatGroupController controller,
      ChatMessage message) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: ["👍", "❤️", "😂", "😮", "😢", "😡"].map((emoji) {
                return GestureDetector(
                  onTap: () {
                    // Update the reaction for the selected emoji
                    message.reaction = emoji;
                    controller
                        .updateMessage(message); // Notify UI about the update
                    Navigator.of(context).pop(); // Close the popup
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      emoji,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  void showProfileDialog(
      BuildContext context, String profilePicture, bool isSender) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                  radius: 50, backgroundImage: AssetImage(profilePicture)),
              const SizedBox(height: 10),
              Text(isSender ? "You" : "Chat Partner",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      },
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    if (difference.inDays == 0 && now.day == timestamp.day) {
      return "Today, ${DateFormat('hh:mm a').format(timestamp)}";
    } else if (difference.inDays == 1 ||
        (difference.inDays == 0 && now.day != timestamp.day)) {
      return "Yesterday, ${DateFormat('hh:mm a').format(timestamp)}";
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE, hh:mm a').format(timestamp);
    } else {
      return DateFormat('MM/dd/yyyy, hh:mm a').format(timestamp);
    }
  }
}

class ChatMessage {
  final String? text;
  final DateTime timestamp;
  final String? imageSend;
  final String? avatarUrl;
  final bool isSentByMe;
  final String senderName;
  String? reaction; // Add this field to store the selected emoji

  ChatMessage({
    this.text,
    required this.timestamp,
    required this.isSentByMe,
    this.imageSend,
    this.avatarUrl,
    this.senderName = "Unknown",
    this.reaction, // Initialize as null by default
  });
}
