import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:userside_ecommerce/firebase_options.dart';
import 'package:userside_ecommerce/views/auth_screen/login_screen.dart';
import 'package:userside_ecommerce/views/auth_screen/signup_screen.dart';
import 'package:userside_ecommerce/views/category_screen/category_screen.dart';
import 'package:userside_ecommerce/views/home_screen/home.dart';
import 'package:userside_ecommerce/views/splash_screen/splash_screen.dart';
import 'consts/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        iconTheme: const IconThemeData(color: darkFontGrey),
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}
