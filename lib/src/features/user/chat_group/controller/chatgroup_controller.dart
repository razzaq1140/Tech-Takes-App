import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../view/chatgroup_view.dart';

class ChatGroupController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // var messages = <String>[].obs;
  // var messageTextController = ''.obs;

  // void sendMessage(String text) {
  //   if (text.isNotEmpty) {
  //     messages.add(text);
  //     messageTextController.value = '';
  //   }
  // }

  // void openCamera() {
  //   // Here you can implement the camera functionality, e.g., using ImagePicker
  //   print("Camera icon tapped");
  // }

  // void openEmojiPicker() {
  //   // Here you can implement the emoji picker functionality
  //   print("Emoji picker icon tapped");
  // }

  // void openAttachment() {
  //   // Here you can implement the attachment functionality
  //   print("Attachment icon tapped");
  // }
  late AnimationController animationController;
  late Animation<double> animation;
  var messages = <ChatMessage>[].obs;
  var isMuted = false.obs;
  var showEmojiPicker = false.obs;

  var showMentionList = false.obs;
  var selectedEmoji = ''.obs;
  File? image;
  String? imagePath;
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  final TextEditingController messageController = TextEditingController();
  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    preloadMessages();

    // Load initial image if passed from another page
    if (imagePath != null && imagePath!.isNotEmpty) {
      addImageMessage(imagePath!);
    }
  }

  void preloadMessages() {
    messages.addAll([
      ChatMessage(
        timestamp: DateTime.now(),
        text: 'Hello! How are you?',
        isSentByMe: false,
        avatarUrl:
            'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      ),
      ChatMessage(
        timestamp: DateTime.now(),
        text: 'I am doing well, thank you!',
        isSentByMe: true,
        avatarUrl:
            'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      ),
    ]);
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void sendMessage(String text) {
    if (text.isNotEmpty) {
      messages.add(ChatMessage(
        text: text,
        isSentByMe: true,
        avatarUrl:
            'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
        timestamp: DateTime.now(),
      ));
      messageController.clear();
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      addImageMessage(pickedImage.path);
    }
  }

  Future<void> pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      addImageMessage(pickedImage.path);
    }
  }

  void addImageMessage(String imagePath) {
    messages.add(ChatMessage(
      timestamp: DateTime.now(),
      isSentByMe: true,
      imageSend: imagePath,
      avatarUrl:
          'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
    ));
    scrollToBottom();
  }

  void toggleMute() => isMuted.value = !isMuted.value;
  void toggleEmojiPicker() => showEmojiPicker.value = !showEmojiPicker.value;

  void updateMessage(ChatMessage updatedMessage) {
    final index =
        messages.indexWhere((m) => m.timestamp == updatedMessage.timestamp);
    if (index != -1) {
      messages[index] = updatedMessage;
      messages.refresh(); // Notify listeners
    }
  }

  void showFullScreenImage(BuildContext context, String imagePath) {
    animationController.forward();
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Center(
              child: ScaleTransition(
                scale: animation,
                child: Hero(
                  tag: imagePath,
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  animationController.reverse();
                  Navigator.of(context).pop();
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ).then((_) {
      animationController.reset();
    });
  }
}
