import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/controller/chats_controller.dart';
import 'package:userside_ecommerce/services/firestore_services.dart';
import 'package:userside_ecommerce/views/chat_screen/components/sender_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          "${controller.friendName}",
          style: const TextStyle(fontFamily: semibold, color: darkFontGrey),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Obx(
              () => controller.isloading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor)))
                  : Expanded(
                      child: StreamBuilder(
                      stream: FirestoreServices.getChatMessages(
                          controller.chatDocId.toString()),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor)),
                          );
                        } else if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text(
                              "Send a message",
                              style: TextStyle(color: darkFontGrey),
                            ),
                          );
                        } else {
                          return ListView(
                            children: snapshot.data!.docs
                                .mapIndexed((currentValue, index) {
                              var data = snapshot.data!.docs[index];
                              return Align(
                                  alignment: data['uid'] == currentUser!.uid
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: senderBubble(data));
                            }).toList(),
                          );
                        }
                      },
                    )),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              height: 80,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.msgController,
                      decoration: const InputDecoration(
                          hintText: "Type a message ...",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: textfieldGrey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: textfieldGrey))),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
