import 'package:userside_ecommerce/consts/consts.dart';

Widget applogoWidget() {
  return Container(
    padding: EdgeInsets.all(8),
    height: 77,
    width: 77,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(9)),
    child: Image.asset(icAppLogo),
  );
}
