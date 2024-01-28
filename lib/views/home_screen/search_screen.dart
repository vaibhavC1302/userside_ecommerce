import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/services/firestore_services.dart';
import 'package:userside_ecommerce/views/category_screen/item_details.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          title!,
          style: const TextStyle(color: darkFontGrey),
        ),
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No products found"),
            );
          } else {
            var data = snapshot.data!.docs;
            var filtered = data
                .where((element) => element['p_name']
                    .toString()
                    .toLowerCase()
                    .contains(title!.toLowerCase()))
                .toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 300),
                children: filtered
                    .mapIndexed((currentValue, index) => InkWell(
                          onTap: () {
                            Get.to(() => ItemDetails(
                                  title: "${filtered[index]['p_name']}",
                                  data: filtered[index],
                                ));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.all(12),
                            color: whiteColor,
                            child: Column(
                              children: [
                                Image.network(
                                  filtered[index]['p_imgs'][0],
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                const Spacer(),
                                Text(
                                  "${filtered[index]['p_name']}",
                                  style: const TextStyle(
                                      fontFamily: semibold,
                                      color: darkFontGrey),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('${filtered[index]['p_price']}',
                                    style: const TextStyle(
                                        fontFamily: bold, color: redColor)),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
