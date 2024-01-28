import 'package:flutter/services.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/widgets_common/out_button.dart';

Widget exitDialog(BuildContext context) {
  return Dialog(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Confirm",
            style: TextStyle(fontSize: 18, color: darkFontGrey),
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Are yor sure you want to exit?",
            style: TextStyle(fontSize: 16, color: darkFontGrey),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ourButton(
                  title: "Yes",
                  buttonColor: redColor,
                  textColor: whiteColor,
                  onPress: () {
                    SystemNavigator.pop();
                  }),
              ourButton(
                  title: "No",
                  buttonColor: redColor,
                  textColor: whiteColor,
                  onPress: () {
                    Navigator.pop(context);
                  }),
            ],
          )
        ],
      ),
    ),
  );
}
