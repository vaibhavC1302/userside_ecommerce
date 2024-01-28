import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:userside_ecommerce/consts/lists.dart';
import 'package:userside_ecommerce/controller/home_controller.dart';
import 'package:userside_ecommerce/controller/product_controller.dart';
import 'package:userside_ecommerce/services/firestore_services.dart';
import 'package:userside_ecommerce/views/category_screen/item_details.dart';
import 'package:userside_ecommerce/views/home_screen/components/featured_button.dart';
import 'package:userside_ecommerce/views/home_screen/search_screen.dart';
import 'package:userside_ecommerce/widgets_common/home_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// product controller onitialized here to get to details screen
    Get.put(ProductController());
    ///////////////////////////////////////////////////////////////
    var controller = Get.find<HomeController>();
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (controller
                          .searchController.text.isNotEmptyAndNotNull) {
                        Get.to(() => SearchScreen(
                              title: controller.searchController.text,
                            ));
                      }
                    },
                    icon: const Icon(Icons.search, color: Colors.blue),
                  ),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: search,
                  hintStyle: TextStyle(color: textfieldGrey),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CarouselSlider(
                      items: sliderList.map((img) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                  image: AssetImage(img), fit: BoxFit.fill)),
                        );
                      }).toList(),
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          height: 150,
                          aspectRatio: 16 / 9),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        homeButton(
                            title: todaysdeal,
                            icon: icTodaysDeal,
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 2.5),
                        homeButton(
                            title: flashSale,
                            icon: icFlashDeal,
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 2.5)
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CarouselSlider(
                      items: secondSliderList.map((img) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                  image: AssetImage(img), fit: BoxFit.fill)),
                        );
                      }).toList(),
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          height: 150,
                          aspectRatio: 16 / 9),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        homeButton(
                            title: topCategories,
                            icon: icTopCategories,
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 3.5),
                        homeButton(
                            title: brand,
                            icon: icBrands,
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 3.5),
                        homeButton(
                            title: topseller,
                            icon: icTopSeller,
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 3.5)
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        featuredCategories,
                        style: TextStyle(
                            fontFamily: bold,
                            fontSize: 18,
                            color: darkFontGrey),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          3,
                          (index) {
                            return featuredButton(
                                title: featuredTitles1[index],
                                img: featuredImages1[index]);
                          },
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          3,
                          (index) {
                            return featuredButton(
                                title: featuredTitles2[index],
                                img: featuredImmages2[index]);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    /////  featured products  ////
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: redColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Featured products",
                            style: TextStyle(fontFamily: bold, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                                future: FirestoreServices.getFeaturedProducts(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation(redColor),
                                      ),
                                    );
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return const Center(
                                      child: Text(
                                        "No featured products",
                                        style: TextStyle(color: whiteColor),
                                      ),
                                    );
                                  } else {
                                    var featuredDate = snapshot.data!.docs;
                                    return Row(
                                      children: List.generate(
                                        featuredDate.length,
                                        (index) => InkWell(
                                          onTap: () {
                                            Get.to(() => ItemDetails(
                                                  title:
                                                      "${featuredDate[index]['p_name']}",
                                                  data: featuredDate[index],
                                                ));
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            decoration: BoxDecoration(
                                                color: whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.network(
                                                  featuredDate[index]['p_imgs']
                                                      [0],
                                                  width: 130,
                                                  height: 130,
                                                  fit: BoxFit.fill,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "${featuredDate[index]['p_name']}",
                                                  style: const TextStyle(
                                                    fontFamily: semibold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "${featuredDate[index]['p_price']}",
                                                  style: const TextStyle(
                                                      color: redColor,
                                                      fontFamily: bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //third swiper
                    CarouselSlider(
                      items: secondSliderList.map((img) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                  image: AssetImage(img), fit: BoxFit.fill)),
                        );
                      }).toList(),
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          height: 150,
                          aspectRatio: 16 / 9),
                    ),

                    //allproducts section
                    const Text(
                      "All products",
                      style: TextStyle(fontFamily: bold, color: fontGrey),
                    ),

                    StreamBuilder(
                        stream: FirestoreServices.allproducts(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor),
                              ),
                            );
                          } else {
                            var allproductsdata = snapshot.data!.docs;
                            return GridView.builder(
                              shrinkWrap: true,
                              itemCount: allproductsdata.length,
                              // physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                mainAxisExtent: 300,
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => ItemDetails(
                                          title:
                                              "${allproductsdata[index]['p_name']}",
                                          data: allproductsdata[index],
                                        ));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          allproductsdata[index]['p_imgs'][0],
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.cover,
                                        ),
                                        const Spacer(),
                                        Text(
                                          "${allproductsdata[index]['p_name']}",
                                          style: const TextStyle(
                                            fontFamily: semibold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "${allproductsdata[index]['p_price']}",
                                          style: const TextStyle(
                                              color: redColor,
                                              fontFamily: bold),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
