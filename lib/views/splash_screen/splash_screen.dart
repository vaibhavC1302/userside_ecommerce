import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/views/auth_screen/login_screen.dart';
import 'package:userside_ecommerce/views/home_screen/home.dart';
import 'package:userside_ecommerce/widgets_common/applogo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => LoginScreen());
        } else {
          Get.to(() => Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                applogoWidget(),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  appname,
                  style: TextStyle(
                      fontFamily: bold, color: Colors.white, fontSize: 22),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  appversion,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              credits,
              style: TextStyle(fontFamily: semibold, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
