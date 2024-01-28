import 'package:userside_ecommerce/consts/consts.dart';

Widget orderStatus({icon, color, title, showDone}) {
  return ListTile(
    leading: Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(style: BorderStyle.solid, color: color)),
      child: Icon(
        icon,
        color: color,
      ),
    ),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: darkFontGrey,
            ),
          ),
          showDone
              ? const Icon(
                  Icons.done,
                  color: redColor,
                )
              : Container()
        ],
      ),
    ),
  );
}
