import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userside_ecommerce/consts/colors.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/controller/product_controller.dart';
import 'package:userside_ecommerce/services/firestore_services.dart';
import 'package:userside_ecommerce/views/category_screen/item_details.dart';
import 'package:userside_ecommerce/widgets_common/bg_widget.dart';

class CategoryDetails extends StatefulWidget {
  final String title;
  const CategoryDetails({super.key, required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    } else {
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.find<ProductController>();
  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(color: whiteColor),
          ),
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  controller.subcat.length,
                  (index) => InkWell(
                    onTap: () {
                      switchCategory("${controller.subcat[index]}");
                      setState(() {});
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 60,
                      width: 120,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        controller.subcat[index],
                        style: const TextStyle(fontFamily: semibold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: productMethod,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "No products found",
                      style: TextStyle(color: whiteColor),
                    ),
                  );
                } else {
                  List<QueryDocumentSnapshot> data = snapshot.data!.docs;
                  return Expanded(
                    child: Container(
                      color: lightGrey,
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          mainAxisExtent: 250,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              controller.checkIfFav(data[index]);
                              Get.to(
                                () => ItemDetails(
                                  title: data[index]['p_name'],
                                  data: data[index],
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    data[index]['p_imgs'][0],
                                    height: 150,
                                    width: 200,
                                    fit: BoxFit.fill,
                                  ),
                                  Text(
                                    data[index]['p_name'],
                                    style: const TextStyle(
                                      fontFamily: semibold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "\$${data[index]['p_price']}",
                                    style: const TextStyle(
                                        color: redColor, fontFamily: bold),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
