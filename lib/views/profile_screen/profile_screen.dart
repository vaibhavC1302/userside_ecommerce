import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/consts/lists.dart';
import 'package:userside_ecommerce/controller/auth_controller.dart';
import 'package:userside_ecommerce/controller/profile_controller.dart';
import 'package:userside_ecommerce/services/firestore_services.dart';
import 'package:userside_ecommerce/views/auth_screen/login_screen.dart';
import 'package:userside_ecommerce/views/chat_screen/messaging_screen.dart';
import 'package:userside_ecommerce/views/orders_screen/orders_screen.dart';
import 'package:userside_ecommerce/views/profile_screen/components/details_card.dart';
import 'package:userside_ecommerce/views/profile_screen/edit_profile_screen.dart';
import 'package:userside_ecommerce/views/wishlist_screen/wishlist_screen.dart';
import 'package:userside_ecommerce/widgets_common/bg_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //profile controller
    var controller = Get.put(ProfileController());
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor)),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      //// edit profile button
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            controller.nameController.text = data['name'];
                            Get.to(() => EditProfileScreen(
                                  data: data,
                                ));
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      ///user details section
                      ///
                      ListTile(
                        leading: CircleAvatar(
                          radius: 40,
                          backgroundImage: (data['imageUrl'] == "")
                              ? const AssetImage(
                                  imgProfile2,
                                )
                              : NetworkImage(data['imageUrl'])
                                  as ImageProvider?,
                        ),
                        title: Text(
                          data['name'],
                          style: const TextStyle(
                              fontFamily: semibold, color: whiteColor),
                        ),
                        subtitle: Text(
                          data['email'],
                          style: const TextStyle(color: whiteColor),
                        ),
                        trailing: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: whiteColor),
                          ),
                          onPressed: () async {
                            Get.put(AuthController())
                                .signoutMethod(context: context);
                            Get.offAll(() => LoginScreen());
                          },
                          child: const Text(
                            "Log out",
                            style: TextStyle(
                                fontFamily: semibold, color: whiteColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      //user order history

                      FutureBuilder(
                        future: FirestoreServices.getCounts(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor),
                              ),
                            );
                          } else {
                            var countdata = snapshot.data;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                detailsCard(
                                  context.screenWidth / 3.4,
                                  countdata[0].toString(),
                                  "in your cart",
                                ),
                                detailsCard(
                                  context.screenWidth / 3.4,
                                  countdata[1].toString(),
                                  "in your wishlist",
                                ),
                                detailsCard(
                                  context.screenWidth / 3.4,
                                  countdata[2].toString(),
                                  "you ordered",
                                ),
                              ],
                            );
                          }
                        },
                      ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     detailsCard(
                      //       context.screenWidth / 3.4,
                      //       data['cart_count'],
                      //       "in your cart",
                      //     ),
                      //     detailsCard(
                      //       context.screenWidth / 3.4,
                      //       data['wishlist_count'],
                      //       "in your wishlist",
                      //     ),
                      //     detailsCard(
                      //       context.screenWidth / 3.4,
                      //       data['order_count'],
                      //       "you ordered",
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 40,
                      ),

                      ///list tiles options
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: profileButtonsList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.to(() => const OrdersScreen());
                                  break;
                                case 1:
                                  Get.to(() => const WishlistScreen());
                                  break;
                                case 2:
                                  Get.to(() => const MessagesScreen());
                                  break;
                              }
                            },
                            horizontalTitleGap: 20,
                            tileColor: lightGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            leading: Image.asset(
                              profileButtonsIcon[index],
                              width: 22,
                            ),
                            title: Text(
                              profileButtonsList[index],
                              style: const TextStyle(fontFamily: semibold),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: lightGrey,
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
