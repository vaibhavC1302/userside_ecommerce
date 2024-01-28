import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/services/firestore_services.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text(
          "My Wishlist",
          style: TextStyle(color: darkFontGrey, fontFamily: semibold),
        ),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlist(),
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
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Image.network(
                          "${data[index]['p_imgs'][0]}",
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          "${data[index]['p_name']} ",
                          style: const TextStyle(
                              fontFamily: semibold, fontSize: 16),
                        ),
                        subtitle: Text(
                          data[index]['p_price'].toString(),
                          style: const TextStyle(color: redColor),
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            await firestore
                                .collection(productsCollection)
                                .doc(data[index].id)
                                .set({
                              'p_wishlist':
                                  FieldValue.arrayRemove([currentUser!.uid])
                            }, SetOptions(merge: true));
                          },
                          icon: const Icon(
                            Icons.favorite,
                            color: redColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
