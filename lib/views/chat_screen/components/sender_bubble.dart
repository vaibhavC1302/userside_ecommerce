import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);

  return Directionality(
    textDirection:
        data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: data['uid'] == currentUser!.uid ? redColor : darkFontGrey,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${data['msg']}",
            style: const TextStyle(color: whiteColor, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            time,
            style: TextStyle(color: whiteColor.withOpacity(0.5)),
          )
        ],
      ),
    ),
  );
}
