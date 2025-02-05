import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tech_takes_app/main.dart';
import 'package:tech_takes_app/src/features/user/chat_group/model/model.dart';

class GroupChatApis {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => auth.currentUser!;
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  static String groupId = "group_chat_room";

  static Future<void> addUserToGroup() async {
    final userRef = firestore.collection('users').doc(user.uid);

    var groupDoc = await firestore.collection('groups').doc(groupId).get();
    if (!groupDoc.exists) {
      await firestore.collection('groups').doc(groupId).set({
        'groupName': 'General Chat',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    await firestore.collection('groups').doc(groupId).update({
      'members': FieldValue.arrayUnion([user.uid]),
    });

    var userDoc = await userRef.get();
    if (userDoc.exists && !userDoc.data()!.containsKey('welcomeMessageSent')) {
      sendWelcomeMessage();

      await userRef.update({
        'welcomeMessageSent': true,
      });
    }
  }

  static Future<void> updateMessage(GroupChatModel message) async {
    await firestore
        .collection('chat/$groupId/messages')
        .doc(message.sent.toString()) // Use timestamp as ID
        .update(message.toJson()); // Save updated message with reactions
  }

  static Future<void> sendWelcomeMessage() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    // final currenteTime = DateTime.now();

    final welcomeMessage = GroupChatModel(
      fromId: user.uid,
      name: user.displayName.toString(),
      time: '',
      msg: ' ${user.displayName} you have joined the Room!',
      reaction: [],
      sent: time,
      told: '',
    );

    await firestore
        .collection('chat/$groupId/messages')
        .doc(time)
        .set(welcomeMessage.toJson());
  }

  static Future<void> sendGroupMessage(String msg) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final message = GroupChatModel(
      name: user.displayName.toString(),
      fromId: user.uid,
      msg: msg,
      time: '',
      reaction: [],
      sent: time,
      told: '',
    );

    await firestore
        .collection('chat/$groupId/messages')
        .doc(time)
        .set(message.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages() {
    return firestore
        .collection('chat/$groupId/messages')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getGroupInfo() {
    return firestore.collection('groups').doc(groupId).snapshots();
  }
}
