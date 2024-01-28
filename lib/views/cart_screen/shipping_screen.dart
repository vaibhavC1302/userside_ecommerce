import 'package:get/get.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/controller/cart_controller.dart';
import 'package:userside_ecommerce/views/cart_screen/payment_methods.dart';
import 'package:userside_ecommerce/widgets_common/custom_textfield.dart';
import 'package:userside_ecommerce/widgets_common/out_button.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text(
          "Shipping information",
          style: TextStyle(fontFamily: semibold, color: darkFontGrey),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
            onPress: () {
              if (controller.addressController.text.length > 10) {
                Get.to(() => PaymentMethods());
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill the form")));
              }
            },
            title: "Continue",
            textColor: whiteColor,
            buttonColor: redColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            customTextField(
                title: "Address",
                hintText: "Address",
                obscureText: false,
                controller: controller.addressController),
            customTextField(
                title: "City",
                hintText: "City",
                obscureText: false,
                controller: controller.cityController),
            customTextField(
                title: "State",
                hintText: "State",
                obscureText: false,
                controller: controller.stateController),
            customTextField(
                title: "Postal Code",
                hintText: "Postal Code",
                obscureText: false,
                controller: controller.postalController),
            customTextField(
                title: "Phone",
                hintText: "Phone",
                obscureText: false,
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
