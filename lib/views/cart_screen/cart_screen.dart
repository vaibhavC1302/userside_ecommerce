import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/controller/cart_controller.dart';
import 'package:userside_ecommerce/services/firestore_services.dart';
import 'package:userside_ecommerce/views/cart_screen/shipping_screen.dart';
import 'package:userside_ecommerce/widgets_common/out_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return Scaffold(
      bottomNavigationBar: SizedBox(
        width: context.screenWidth - 20,
        child: ourButton(
            title: "Proceed to shipping",
            buttonColor: redColor,
            textColor: whiteColor,
            onPress: () {
              Get.to(() => ShippingDetails());
            }),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Shopping Cart",
          style: TextStyle(color: darkFontGrey, fontFamily: semibold),
        ),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getcart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "Cart is empty",
                style: TextStyle(color: darkFontGrey),
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network(
                            "${data[index]['img']}",
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            "${data[index]['title']} x(${data[index]['qty']})",
                            style: const TextStyle(
                                fontFamily: semibold, fontSize: 16),
                          ),
                          subtitle: Text(
                            data[index]['tprice'].toString(),
                            style: const TextStyle(color: redColor),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              FirestoreServices.deleteDocument(data[index].id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: redColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // total and proceeding buttons //////////
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: lightGolden),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Price",
                          style: TextStyle(
                              fontFamily: semibold, color: darkFontGrey),
                        ),
                        Obx(
                          () => Text(
                            "${controller.totalP.value}",
                            style: const TextStyle(
                                fontFamily: semibold, color: redColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
