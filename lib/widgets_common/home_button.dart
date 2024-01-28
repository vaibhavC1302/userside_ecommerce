import 'package:userside_ecommerce/consts/consts.dart';

Widget homeButton({
  required title,
  required icon,
  VoidCallback? onPress,
  required double height,
  required double width,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        color: whiteColor, borderRadius: BorderRadius.circular(8)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: 26,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: const TextStyle(fontFamily: semibold, color: darkFontGrey),
        )
      ],
    ),
  );
}
