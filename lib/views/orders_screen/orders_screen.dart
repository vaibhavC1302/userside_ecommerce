import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/services/firestore_services.dart';
import 'package:userside_ecommerce/views/orders_screen/order_details.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text(
          "My Orders",
          style: TextStyle(color: darkFontGrey, fontFamily: semibold),
        ),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No orders yet"),
            );
          } else {
            var data = snapshot.data!.docs;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text(
                    "${index + 1}",
                    style: const TextStyle(
                        color: darkFontGrey, fontFamily: bold, fontSize: 22),
                  ),
                  title: Text(
                    data[index]['order_code'].toString(),
                    style: const TextStyle(
                      color: redColor,
                      fontFamily: semibold,
                    ),
                  ),
                  subtitle: Text(
                    data[index]['total_amount'].toString(),
                    style: const TextStyle(
                      color: darkFontGrey,
                      fontFamily: bold,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Get.to(() => OrderDetails(
                            data: data[index],
                          ));
                    },
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
