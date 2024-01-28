import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userside_ecommerce/consts/colors.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/consts/lists.dart';
import 'package:userside_ecommerce/controller/cart_controller.dart';
import 'package:userside_ecommerce/views/home_screen/home.dart';
import 'package:userside_ecommerce/widgets_common/out_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                )
              : ourButton(
                  onPress: () async {
                    await controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethods[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);
                    await controller.clearCart();

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("order placed successfully")));

                    Get.offAll(const Home());
                  },
                  title: "Continue",
                  textColor: whiteColor,
                  buttonColor: redColor),
        ),
        appBar: AppBar(
          title: const Text(
            "Choose Payment Method",
            style: TextStyle(fontFamily: semibold, color: darkFontGrey),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Obx(
            () => Column(
              children: List.generate(
                paymentMethodsImg.length,
                (index) {
                  return InkWell(
                    onTap: () {
                      controller.changePaymentIndex(index);
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: controller.paymentIndex.value == index
                                ? redColor
                                : Colors.transparent,
                            width: 4),
                      ),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.asset(
                            paymentMethodsImg[index],
                            width: double.infinity,
                            colorBlendMode:
                                controller.paymentIndex.value == index
                                    ? BlendMode.darken
                                    : BlendMode.color,
                            color: controller.paymentIndex.value == index
                                ? Colors.black.withOpacity(0.4)
                                : Colors.transparent,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          controller.paymentIndex.value == index
                              ? Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                      activeColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      value: true,
                                      onChanged: (value) {}),
                                )
                              : Container(),
                          Positioned(
                            bottom: 10,
                            right: 0,
                            child: Text(
                              "${paymentMethods[index]}",
                              style: TextStyle(
                                  fontFamily: bold,
                                  color: whiteColor,
                                  fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
