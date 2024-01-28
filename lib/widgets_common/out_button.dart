import 'package:userside_ecommerce/consts/consts.dart';

Widget ourButton(
    {String? title,
    Color? buttonColor,
    Color? textColor,
    VoidCallback? onPress}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: buttonColor,
      minimumSize: const Size(500, 50),
    ),
    onPressed: onPress,
    child: Text(
      title!,
      style: TextStyle(fontSize: 18, color: textColor),
    ),
  );
}
