import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/services/firestore_services.dart';
import 'package:userside_ecommerce/views/chat_screen/chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text(
          "My messages",
          style: TextStyle(color: darkFontGrey, fontFamily: semibold),
        ),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Nothing in wishlist yet"),
            );
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Get.to(() => ChatScreen(), arguments: [
                                data[index]['friend_name'],
                                data[index]['toId']
                              ]);
                            },
                            leading: const CircleAvatar(
                              backgroundColor: redColor,
                              child: Icon(
                                Icons.person,
                                color: whiteColor,
                              ),
                            ),
                            title: Text(
                              "${data[index]['friend_name']}",
                              style: const TextStyle(
                                  fontFamily: semibold, color: darkFontGrey),
                            ),
                            subtitle: Text(
                              "${data[index]['last_msg']}",
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
