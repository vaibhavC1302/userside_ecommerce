import 'package:userside_ecommerce/consts/consts.dart';

Widget customTextField(
    {String? title,
    String? hintText,
    bool? obscureText,
    TextEditingController? controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title!,
        style: const TextStyle(
            color: Colors.red, fontSize: 16, fontFamily: semibold),
      ),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        controller: controller,
        obscureText: obscureText!,
        decoration: InputDecoration(
          hintText: hintText!,
          hintStyle:
              const TextStyle(fontFamily: semibold, color: textfieldGrey),
          fillColor: lightGrey,
          filled: true,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: redColor),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      )
    ],
  );
}
