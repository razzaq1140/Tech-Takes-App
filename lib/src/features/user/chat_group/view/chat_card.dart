// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:tech_takes_app/src/common/constants/global_variable.dart';
// import 'package:tech_takes_app/src/features/user/chat_group/model/model.dart';
// import 'package:tech_takes_app/src/features/user/chat_group/repository/firebase_services.dart';
// import 'package:tech_takes_app/src/features/user/chat_group/view/all_user.dart';
// import 'package:tech_takes_app/src/features/user/chat_group/view/user_chat.dart';
// import 'package:tech_takes_app/src/features/user/prediction/widget/custom_container.dart';

// class ChatCard extends StatefulWidget {
//   final ChatUser user;
//   final VoidCallback? ontap;
//   const ChatCard({
//     super.key,
//     required this.user,
//     this.ontap,
//   });

//   @override
//   State<ChatCard> createState() => _ChatCardState();
// }

// class _ChatCardState extends State<ChatCard> {
//   @override
//   GroupChatModel message = GroupChatModel(
//     fromId: '',
//     msg: '',
//     reaction: '',
//     sent: '',
//     told: '',
//   );
//   Widget build(BuildContext context) {
//     return CustomContainer(
//       color: Colors.transparent,
//       height: 65,
//       width: 335,
//       child: GestureDetector(
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => UserChatScreen(
//                     user: widget.user,
//                   ),
//                 ));
//             print('object');
//           },
//           child: StreamBuilder(
//             stream: MessageModal.getLastMessages(widget.user),
//             builder: (context, snapshot) {
//               final data = snapshot.data?.docs;
//               final list = data
//                       ?.map((e) => GroupChatModel.fromJson(e.data()))
//                       .toList() ??
//                   [];
//               if (list.isNotEmpty) message = list[0];
//               return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           height: 50,
//                           width: 50,
//                           child: ClipOval(
//                             child: CachedNetworkImage(
//                               height: 50,
//                               // color: Colors.blue,
//                               width: 50,
//                               fit: BoxFit.cover,
//                               imageUrl: widget.user.image,
//                               errorWidget: (context, url, error) {
//                                 return CircleAvatar(
//                                   child: Icon(CupertinoIcons.person),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   widget.user!.name.toString(),
//                                   style:
//                                       textTheme(context).bodyMedium?.copyWith(
//                                             color: Color(0xff929292),
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                                 width: 210,
//                                 child: Text(
//                                     overflow: TextOverflow.ellipsis,
//                                     message != null ? message!.msg : 'hi',
//                                     maxLines: 1,
//                                     style:
//                                         textTheme(context).bodySmall?.copyWith(
//                                               color: Color(0xff929292),
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w500,
//                                             )))
//                           ],
//                         ),
//                         Spacer(),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Container(
//                         height: 1,
//                         width: 263,
//                         decoration: BoxDecoration(
//                             color: Color(0xff000000).withOpacity(.060)),
//                       ),
//                     )
//                   ],
//                 ),
//               );
//             },
//           )),
//     );
//   }
// }
