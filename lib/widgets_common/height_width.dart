import 'package:userside_ecommerce/consts/consts.dart';

double getHeight(context, value) {
  return MediaQuery.of(context).size.height * value;
}

double getWidth(context, value) {
  return MediaQuery.of(context).size.width * value;
}
