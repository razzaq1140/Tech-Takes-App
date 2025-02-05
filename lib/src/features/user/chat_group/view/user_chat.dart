// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:tech_takes_app/src/features/user/chat_group/model/model.dart';
// import 'package:tech_takes_app/src/features/user/chat_group/repository/firebase_services.dart';
// import 'package:tech_takes_app/src/features/user/chat_group/view/message_card.dart';

// class UserChatScreen extends StatefulWidget {
//   final ChatUser user;

//   UserChatScreen({super.key, required this.user});

//   @override
//   State<UserChatScreen> createState() => User_ChatScreenState();
// }

// class User_ChatScreenState extends State<UserChatScreen> {
//   TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   void _scrollToBottom() {
//     if (_scrollController.hasClients) {
//       _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//     }
//   }

//   FirebaseAuth auth = FirebaseAuth.instance;
//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollToBottom();
//     });
//   }

//   @override
//   List<GroupChatModel> _list = [];
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffFDE4E4),
//       appBar: AppBar(
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         title: Row(
//           children: [
//             StreamBuilder(
//               stream: MessageModal.getUserInfo(widget.user),
//               builder: (context, snapshot) {
//                 final data = snapshot.data?.docs;
//                 final list =
//                     data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
//                         [];
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       list.isNotEmpty ? list[0].name : widget.user.name,
//                       style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 17,
//                           fontWeight: FontWeight.w700),
//                     ),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.circle,
//                           color: list.isNotEmpty
//                               ? list[0].isOnline
//                                   ? Colors.green
//                                   : Colors.white
//                               : Colors.white,
//                           size: 12,
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           list.isNotEmpty
//                               ? list[0].isOnline
//                                   ? 'Online'
//                                   : 'offLine'
//                               : 'OffLine',
//                           style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400),
//                         ),
//                       ],
//                     ),
//                   ],
//                 );
//               },
//             ),
//             Expanded(
//                 child: Align(
//                     alignment: Alignment.centerRight,
//                     child: InkWell(onTap: () {}, child: Icon(Icons.call)))),
//             SizedBox(
//               width: 20,
//             ),
//             InkWell(
//               onTap: () {},
//               child: Icon(Icons.video_call),
//             )
//           ],
//         ),
//       ),
//       body: Column(children: [
//         Expanded(
//           child: StreamBuilder(
//             stream: MessageModal.getAllMessages(widget.user),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else if (snapshot.hasData) {
//                 final datas = snapshot.data?.docs;
//                 _list = datas
//                         ?.map((e) => GroupChatModel.fromJson(e.data()))
//                         .toList() ??
//                     [];

//                 if (_list.isNotEmpty) {
//                   return ListView.builder(
//                       itemCount: _list.length,
//                       controller: _scrollController,
//                       reverse: true,
//                       itemBuilder: (context, index) => SizedBox()
//                       // MessageCard(
//                       //   message: _list[index],
//                       // ),
//                       );
//                 } else {
//                   return Center(
//                     child: Text(
//                       'No messages found!',
//                     ),
//                   );
//                 }
//               } else {
//                 return Center(
//                   child: Text(
//                     'No connection found!',
//                   ),
//                 );
//               }
//             },
//           ),
//         ),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.06,
//               child: TextField(
//                 controller: _controller,
//                 decoration: InputDecoration(
//                   prefixIcon: Transform.scale(
//                       scale: 0.5,
//                       child: InkWell(
//                         onTap: () async {},
//                         child: Icon(Icons.add),
//                       )),
//                   suffixIcon: Transform.scale(
//                       scale: 0.5,
//                       child: InkWell(
//                           onTap: () async {
//                             if (_controller.text.isNotEmpty) {
//                               MessageModal.sendMessage(
//                                   widget.user, _controller.text);
//                               _controller.text = '';

//                               log('hanan nam :${widget.user.name}');
//                               log('hanan token :${widget.user.pushToken}');
//                               log('vcv nam :${widget.user.name}');
//                               log('vcv :${widget.user.pushToken}');
//                             }
//                           },
//                           child: Icon(Icons.send))),
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
//                   hintText: 'Type here...',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                     borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                     borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                     borderSide: BorderSide(color: Colors.pink.withOpacity(.5)),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         )
//       ]),
//     );
//   }
// }
