import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/features/user/chat_group/controller/chatgroup_controller.dart';
import 'package:tech_takes_app/src/features/user/chat_group/model/model.dart';
import 'package:tech_takes_app/src/features/user/chat_group/repository/firebase_services.dart';
import 'package:tech_takes_app/src/features/user/chat_group/view/helper.dart';
import 'package:tech_takes_app/src/features/user/prediction/widget/custom_container.dart';

class MessageCard extends StatelessWidget {
  GroupChatModel chatModel;

  MessageCard({super.key, required this.chatModel});

  final ChatGroupController controller = Get.put(ChatGroupController());

  @override
  Widget build(BuildContext context) {
    return GroupChatApis.user.uid == chatModel.fromId
        ? myMessage(context)
        : otherUser(context);
  }

  Widget otherUser(
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  height: 45,
                  fit: BoxFit.cover,

                  // color: Colors.blue,
                  width: 45,
                  imageUrl: chatModel.fromId,
                  errorWidget: (context, url, error) {
                    return CircleAvatar(
                      child: Icon(CupertinoIcons.person),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: GestureDetector(
              // onLongPress: () {},
              onLongPress: () {
                _showReactionPopup(
                  context,
                  controller,
                  chatModel,
                );
                log('Reacht emoji at ${chatModel.reaction} ${chatModel.msg}');
              },
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chatModel.name,
                          style: textTheme(context).bodySmall?.copyWith(
                              color: AppColor.chatUserNameColor,
                              fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          child: Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              padding: chatModel.msg.length < 5
                                  ? EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8)
                                  : EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      bottomLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                  color: AppColor.otherUserChatColor),
                              child: Text(
                                '${chatModel.msg}',
                                maxLines: null,
                                textAlign: TextAlign.start,
                                style: textTheme(context).bodySmall?.copyWith(
                                    color: AppColor.chatUserNameColor),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              MyDateUtils.getFormatedTime(
                                  context, chatModel.sent),
                              style: textTheme(context).bodySmall?.copyWith(
                                  fontSize: 8, color: AppColor.chatTimeColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: CustomContainer(
                      borderRadius: 20,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.grey.withOpacity(.2),
                      child: Center(
                        child: chatModel.reaction.isNotEmpty
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: chatModel.reaction.map((entry) {
                                  return Row(
                                    children: [
                                      // Display emoji
                                      Text(entry.emoji,
                                          style: TextStyle(fontSize: 20)),
                                      SizedBox(width: 4),
                                      // Display count of reactions for this emoji
                                      Text(
                                        ' x${entry.count}',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(width: 8),
                                    ],
                                  );
                                }).toList(),
                              )
                            : Container(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget myMessage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onLongPress: () {},
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          padding: chatModel.msg.length < 5
                              ? EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8)
                              : EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  topRight: Radius.circular(0),
                                  bottomRight: Radius.circular(15)),
                              color: colorScheme(context).primary),
                          child: Text(
                            chatModel.msg,
                            maxLines: null,
                            style: textTheme(context)
                                .bodySmall
                                ?.copyWith(color: colorScheme(context).surface),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          MyDateUtils.getFormatedTime(context, chatModel.sent),
                          style: textTheme(context).bodySmall?.copyWith(
                              color: AppColor.chatTimeColor, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void _showReactionPopup(BuildContext context, ChatGroupController controller,
  //     GroupChatModel chatModel) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => Dialog(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12.0),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: SingleChildScrollView(
  //           scrollDirection: Axis.horizontal,
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: ["👍", "❤️", "😂", "😮", "😢", "😡"].map((emoji) {
  //               return GestureDetector(
  //                 onTap: () async {
  //                   String userId = auth.currentUser!.uid; // Current user's ID
  //                   List<Reaction> updatedReactions =
  //                       List.from(chatModel.reaction);

  //                   // Check if the user has already reacted with any emoji
  //                   Reaction? existingReaction = updatedReactions.firstWhere(
  //                     (reaction) => reaction.userId == userId,
  //                     orElse: () => Reaction(
  //                         emoji: '',
  //                         userId: userId,
  //                         count: 0), // Default Reaction with empty emoji
  //                   );

  //                   if (existingReaction != null) {
  //                     if (existingReaction.emoji == emoji) {
  //                       // If user taps the same emoji, remove their reaction
  //                       updatedReactions.remove(existingReaction);
  //                     } else {
  //                       // If user taps a new emoji, replace the old reaction with the new one
  //                       updatedReactions.remove(existingReaction);
  //                       updatedReactions
  //                           .add(Reaction(emoji: emoji, userId: userId));
  //                     }
  //                   } else {
  //                     // If user hasn't reacted yet, add their reaction with the new emoji
  //                     updatedReactions
  //                         .add(Reaction(emoji: emoji, userId: userId));
  //                   }

  //                   // Update Firestore with the new reaction list
  //                   await FirebaseFirestore.instance
  //                       .collection('chat/group_chat_room/messages')
  //                       .doc(chatModel.sent)
  //                       .update({
  //                     'reaction':
  //                         updatedReactions.map((e) => e.toJson()).toList(),
  //                   });

  //                   // Notify UI to update (e.g., via controller)
  //                   // controller.updateMessage(chatModel); // Update model or state here

  //                   Navigator.of(context).pop(); // Close the popup
  //                 },
  //                 child: Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                   child: Text(
  //                     emoji,
  //                     style: const TextStyle(fontSize: 20),
  //                   ),
  //                 ),
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  FirebaseAuth auth = FirebaseAuth.instance;

  // void _showReactionPopup(BuildContext context, ChatGroupController controller,
  //     GroupChatModel chatModel) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => Dialog(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12.0),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: SingleChildScrollView(
  //           scrollDirection: Axis.horizontal,
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: ["👍", "❤️", "😂", "😮", "😢", "😡"].map((emoji) {
  //               return GestureDetector(
  //                 onTap: () async {
  //                   String userId = auth.currentUser!.uid; // Current user's ID
  //                   List<Reaction> updatedReactions =
  //                       List.from(chatModel.reaction);

  //                   // Find the reaction for the current emoji
  //                   Reaction? existingReaction = updatedReactions.firstWhere(
  //                     (reaction) => reaction.emoji == emoji,
  //                     orElse: () => Reaction(emoji: emoji, count: 0),
  //                   );

  //                   if (existingReaction.count > 0) {
  //                     // If the user has already reacted with this emoji, remove their reaction (toggle)
  //                     updatedReactions.remove(existingReaction);
  //                     // Decrease count if there are other reactions
  //                     if (existingReaction.count > 1) {
  //                       updatedReactions.add(Reaction(
  //                           emoji: emoji, count: existingReaction.count - 1));
  //                     }
  //                   } else {
  //                     // If the user hasn't reacted, add a new reaction and increment count
  //                     updatedReactions.add(Reaction(emoji: emoji, count: 1));
  //                   }

  //                   // Update Firestore with the new reaction list
  //                   await FirebaseFirestore.instance
  //                       .collection('chat/group_chat_room/messages')
  //                       .doc(chatModel.sent)
  //                       .update({
  //                     'reaction':
  //                         updatedReactions.map((e) => e.toJson()).toList(),
  //                   });

  //                   // Notify UI to update (e.g., via controller)
  //                   // controller.updateMessage(chatModel); // Update model or state here

  //                   Navigator.of(context).pop(); // Close the popup
  //                 },
  //                 child: Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                   child: Text(
  //                     emoji,
  //                     style: const TextStyle(fontSize: 20),
  //                   ),
  //                 ),
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // void _showReactionPopup(BuildContext context, ChatGroupController controller,
  //     GroupChatModel chatModel) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => Dialog(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12.0),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: SingleChildScrollView(
  //           scrollDirection: Axis.horizontal,
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: ["👍", "❤️", "😂", "😮", "😢", "😡"].map((emoji) {
  //               return GestureDetector(
  //                 onTap: () async {
  //                   String userId = auth.currentUser!.uid; // Current user's ID
  //                   List<Reaction> updatedReactions =
  //                       List.from(chatModel.reaction);

  //                   // Find the reaction for the current emoji
  //                   Reaction? existingReaction = updatedReactions.firstWhere(
  //                     (reaction) => reaction.emoji == emoji,
  //                     orElse: () => Reaction(emoji: emoji, count: 0),
  //                   );

  //                   // If the user has already reacted, do nothing
  //                   if (existingReaction.count == 0) {
  //                     // Add the user's reaction to the emoji (increment count)
  //                     updatedReactions.add(Reaction(emoji: emoji, count: 1));
  //                   } else {
  //                     // If the emoji exists, only increment the count for that emoji
  //                     updatedReactions = updatedReactions.map((reaction) {
  //                       if (reaction.emoji == emoji) {
  //                         return Reaction(
  //                             emoji: emoji, count: reaction.count + 1);
  //                       }
  //                       return reaction;
  //                     }).toList();
  //                   }

  //                   // Update Firestore with the new reaction list
  //                   await FirebaseFirestore.instance
  //                       .collection('chat/group_chat_room/messages')
  //                       .doc(chatModel.sent)
  //                       .update({
  //                     'reaction':
  //                         updatedReactions.map((e) => e.toJson()).toList(),
  //                   });

  //                   // Notify UI to update (e.g., via controller)
  //                   // controller.updateMessage(chatModel); // Update model or state here

  //                   Navigator.of(context).pop(); // Close the popup
  //                 },
  //                 child: Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                   child: Text(
  //                     emoji,
  //                     style: const TextStyle(fontSize: 20),
  //                   ),
  //                 ),
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  void _showReactionPopup(BuildContext context, ChatGroupController controller,
      GroupChatModel chatModel) {
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
                  onTap: () async {
                    String userId = auth.currentUser!.uid; // Current user's ID
                    List<Reaction> updatedReactions =
                        List.from(chatModel.reaction);

                    // Find the existing reaction from the user
                    // Reaction? existingReaction = updatedReactions.firstWhere(
                    //   (reaction) => reaction.userId == userId,
                    //   orElse: () => null, // If no reaction, return null
                    // );
                    Reaction? existingReaction = updatedReactions.firstWhere(
                      (reaction) => reaction.userId == userId,
                      orElse: () => Reaction(
                          emoji: '',
                          userId: userId,
                          count: 0), // Default Reaction with empty emoji
                    );

                    // If the user already reacted, and they tap the same emoji, remove it
                    if (existingReaction != null) {
                      if (existingReaction.emoji == emoji) {
                        // Remove the user's reaction (toggle)
                        updatedReactions.remove(existingReaction);
                      } else {
                        // If the user tapped a new emoji, remove the old one and add the new one
                        updatedReactions.remove(
                            existingReaction); // Remove the old reaction
                        updatedReactions.add(
                            Reaction(emoji: emoji, userId: userId, count: 1));
                      }
                    } else {
                      // If no reaction, just add their reaction to the emoji
                      updatedReactions.add(
                          Reaction(emoji: emoji, userId: userId, count: 1));
                    }

                    // Update Firestore with the new reaction list
                    await FirebaseFirestore.instance
                        .collection('chat/group_chat_room/messages')
                        .doc(chatModel.sent)
                        .update({
                      'reaction':
                          updatedReactions.map((e) => e.toJson()).toList(),
                    });

                    // Notify UI to update (e.g., via controller)
                    // controller.updateMessage(chatModel); // Update model or state here

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
}
