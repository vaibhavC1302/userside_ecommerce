import 'package:get/get.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/views/category_screen/category_details.dart';

Widget featuredButton({String? title, String? img}) {
  return InkWell(
    onTap: () {
      Get.to(() => CategoryDetails(title: title));
    },
    child: Container(
      height: 60,
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Image.asset(
            img!,
            width: 60,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title!,
            style: const TextStyle(fontFamily: semibold, color: darkFontGrey),
          )
        ],
      ),
    ),
  );
}
