import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userside_ecommerce/consts/colors.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/consts/lists.dart';
import 'package:userside_ecommerce/controller/product_controller.dart';
import 'package:userside_ecommerce/views/chat_screen/chat_screen.dart';
import 'package:userside_ecommerce/widgets_common/out_button.dart';

class ItemDetails extends StatelessWidget {
  final String title;
  final dynamic data;
  const ItemDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetValues();
                Get.back();
              },
              icon: Icon(Icons.arrow_back)),
          title: Text(
            title,
            style: const TextStyle(color: darkFontGrey, fontFamily: bold),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share),
            ),
            Obx(
              () => IconButton(
                onPressed: () {
                  if (controller.isFav.value) {
                    controller.removeFromWishlist(data.id, context);
                  } else {
                    controller.addToWishlist(data.id, context);
                  }
                },
                icon: Icon(
                  Icons.favorite,
                  color: controller.isFav.value ? redColor : darkFontGrey,
                ),
              ),
            )
          ],
        ),
        body: Column(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider.builder(
                      itemCount: data['p_imgs'].length,
                      itemBuilder: (context, index, pageViewIndex) {
                        print(data['p_imgs'][0]);
                        return Image.network(data['p_imgs'][index]);
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        height: 350,
                        aspectRatio: 16 / 9,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                          color: darkFontGrey, fontFamily: bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //rating bar
                    // insert here

                    /////////////
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "\$${data['p_price']}",
                      style: const TextStyle(
                          color: redColor, fontFamily: bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 60,
                      color: textfieldGrey,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Seller",
                                  style: TextStyle(
                                      color: whiteColor, fontFamily: semibold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${data['p_seller']}",
                                  style: const TextStyle(
                                      color: darkFontGrey,
                                      fontFamily: semibold),
                                )
                              ],
                            ),
                          ),
                          CircleAvatar(
                              backgroundColor: whiteColor,
                              child: IconButton(
                                onPressed: () {
                                  Get.to(() => ChatScreen(), arguments: [
                                    data['p_seller'],
                                    data['vendor_id']
                                  ]);
                                },
                                icon: Icon(
                                  Icons.message,
                                  color: darkFontGrey,
                                ),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //  select color section

                    Obx(
                      () => Container(
                        color: whiteColor,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 100,
                                    child: Text(
                                      "Color",
                                      style: TextStyle(color: darkFontGrey),
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(
                                      data['p_colors'].length,
                                      (index) => InkWell(
                                        onTap: () {
                                          controller.changeColorIndex(index);
                                        },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              decoration: BoxDecoration(
                                                  color: Color(
                                                      data['p_colors'][index]),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40)),
                                            ),
                                            Visibility(
                                              visible: index ==
                                                  controller.colorIndex.value,
                                              child: Icon(
                                                Icons.done,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )

                            //quantity selection
                          ],
                        ),
                      ),
                    ),

                    //quantity selection

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: whiteColor,
                      child: Obx(
                        () => Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 100,
                                    child: Text(
                                      "Quantity",
                                      style: TextStyle(color: textfieldGrey),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          controller.decreaseQuantity();
                                          controller.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                      Text(
                                        controller.quantity.value.toString(),
                                        style: const TextStyle(
                                          color: darkFontGrey,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          controller.increaseQuantity(
                                              int.parse(data['p_quantity']));
                                          controller.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${data['p_quantity']} available",
                                        style: const TextStyle(
                                            color: textfieldGrey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 100,
                                    child: Text(
                                      "Total",
                                      style: TextStyle(color: textfieldGrey),
                                    ),
                                  ),
                                  Text(
                                    "${controller.totalPrice.value}",
                                    style: TextStyle(
                                        color: redColor,
                                        fontFamily: bold,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    // description section box
                    SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Description",
                      style:
                          TextStyle(color: darkFontGrey, fontFamily: semibold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      data['p_desc'],
                      style: const TextStyle(
                          color: darkFontGrey, fontFamily: semibold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: List.generate(
                          itemdetailsbuttonlist.length,
                          (index) => ListTile(
                                title: Text(itemdetailsbuttonlist[index],
                                    style: const TextStyle(
                                        color: darkFontGrey,
                                        fontFamily: semibold)),
                                trailing: const Icon(Icons.arrow_forward),
                              )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      productsyoumaylike,
                      style: TextStyle(
                          color: darkFontGrey, fontFamily: bold, fontSize: 16),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          6,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  imgP1,
                                  width: 150,
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Laptop 4GB/64GB",
                                  style: TextStyle(
                                    fontFamily: semibold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "\$600",
                                  style: TextStyle(
                                      color: redColor, fontFamily: bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ourButton(
              title: "Add to cart",
              buttonColor: redColor,
              textColor: whiteColor,
              onPress: () {
                if (controller.quantity.value > 0) {
                  controller.addToCart(
                      color: data['p_colors'][controller.colorIndex.value],
                      vendorId: data['vendor_id'],
                      context: context,
                      img: data['p_imgs'][0],
                      qty: controller.quantity.value,
                      sellername: data['p_seller'],
                      title: data['p_name'],
                      tprice: controller.totalPrice.value);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Added to cart successfully"),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Add quantity")));
                }
              },
            ),
          )
        ]),
      ),
    );
  }
}
