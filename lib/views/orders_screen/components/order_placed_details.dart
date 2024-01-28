import 'package:userside_ecommerce/consts/consts.dart';

Widget orderPlacedDetails({title1, title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$title1",
              style: const TextStyle(
                fontFamily: semibold,
              ),
            ),
            Text(
              "${d1}",
              style: const TextStyle(color: redColor, fontFamily: semibold),
            )
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title2,
                style: const TextStyle(
                  fontFamily: semibold,
                ),
              ),
              Text(d2)
            ],
          ),
        )
      ],
    ),
  );
}
