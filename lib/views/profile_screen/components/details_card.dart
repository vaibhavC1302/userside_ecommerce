import 'package:userside_ecommerce/consts/consts.dart';

Widget detailsCard(double? width, String? count, String? title) {
  return Container(
    height: 80,
    width: width,
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count!,
          style: const TextStyle(
            fontSize: 16,
            color: darkFontGrey,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title!,
          style: const TextStyle(color: darkFontGrey),
        )
      ],
    ),
  );
}
